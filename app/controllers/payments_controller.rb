class PaymentsController < ApplicationController

  def index

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
    if payment.save
      current_user.grant "pro_user"
      flash[:alert] = "You are now a premium user"
      redirect_to messages_home_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:card_number, :card_name, :date_exp, :code, :plan)
  end
end
