class PaymentsController < ApplicationController

  def index
    @payment = Payment.new
  end

  def show

  end

  def new
    @payment = Payment.new
  end

  def create
    user_id = params[:payment][:user]
    user = User.find(user_id)
    payment = Payment.new(payment_params)
    payment.user = user
    p payment_params[:plan]
    if payment_params[:plan].to_i == 1
      payment.message_count = 10
    elsif payment_params[:plan].to_i == 2
      payment.message_count = 100
    elsif payment_params[:plan].to_i == 3
      payment.message_count = -1
    end

    if payment.save
      user.grant "pro_user_" + payment_params[:plan]
      if user.save
        flash[:notice] = "You are now a premium user"
        redirect_to messages_home_path
      end
    end
  end

  def update
    user_id = params[:id]
    user = User.find(user_id)
    payment = Payment.find_by(user: user)
    current_plan = payment.plan
    payment.plan = params[:payment][:plan]
    if current_plan != 3
      if payment_params[:plan].to_i == 1
        payment.message_count += 10
        payment.exp_date = Time.now + 30.days
      elsif payment_params[:plan].to_i == 2
        payment.message_count += 100
        payment.exp_date = Time.now + 30.days
      elsif payment_params[:plan].to_i == 3
        payment.message_count = -1
        payment.exp_date = Time.now + 30.days
      end
    else
      days = payment.exp_date - Date.today
      if payment_params[:plan].to_i == 1
        payment.message_count = (days*100)+10
        payment.exp_date = Time.now + 30.days
      elsif payment_params[:plan].to_i == 2
        payment.message_count = (days*100)+100
        payment.exp_date = Time.now + 30.days
      end
    end
    if payment.save
      user.revoke :pro_user_1 if user.has_role? :pro_user_1
      user.revoke :pro_user_2 if user.has_role? :pro_user_2
      user.revoke :pro_user_3 if user.has_role? :pro_user_3
      user.grant "pro_user_" + params[:payment][:plan]
      if user.save
        if payment.message_count != -1
          flash[:notice] = "You now have "+payment.message_count.to_s+" messages and your account will expire on "+payment.exp_date.to_s
        else
          flash[:notice] = "You now have unlimited messages and your account will expire on "+payment.exp_date.to_s
        end
        redirect_to messages_home_path
      end
    end
  end

  def extend_my_plan
    user_id = params[:id]
    user = User.find(user_id)
    payment = Payment.find_by(user: user)
    payment.exp_date += 30.days
    current_plan = payment.plan
      if current_plan.to_i == 1
        payment.message_count += 10
      elsif current_plan.to_i == 2
        payment.message_count += 100
      elsif current_plan.to_i == 3
        payment.message_count = -1
      end
    if payment.save
      if payment.message_count != -1
        flash[:notice] = "You now have "+payment.message_count.to_s+" messages and your account will expire on "+payment.exp_date.to_s
      else
        flash[:notice] = "You now have unlimited messages and your account will expire on "+payment.exp_date.to_s
      end
      redirect_to messages_home_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:card_number, :card_name, :date_exp, :code, :plan)
  end
end
