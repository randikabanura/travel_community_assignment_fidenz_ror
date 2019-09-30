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
      payment.message_count = 0
    end

    if payment.save
      user.grant "pro_user_" + payment_params[:plan]
      if user.save
        flash[:alert] = "You are now a premium user"
        redirect_to messages_home_path
        end
    end
  end

  def update
    user_id = params[:id]
    user = User.find(user_id)
    payment = Payment.find_by(user: user)
    payment.plan = params[:payment][:plan]
    if payment_params[:plan].to_i == 1
      payment.message_count += 10
      payment.exp_date += 30.days
    elsif payment_params[:plan].to_i == 2
      payment.message_count += 100
      payment.exp_date += 30.days
    elsif payment_params[:plan].to_i == 3
      payment.message_count = 0
      payment.exp_date = Time.now + 30.days
    end
    if payment.save
      user.remove_role :pro_user_1
      user.remove_role :pro_user_2
      user.remove_role :pro_user_3
      user.grant "pro_user_" + params[:payment][:plan]
      if user.save
        redirect_to messages_home_path
      end
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:card_number, :card_name, :date_exp, :code, :plan)
  end
end
