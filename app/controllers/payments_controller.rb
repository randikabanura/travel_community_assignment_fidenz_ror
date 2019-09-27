class PaymentsController < ApplicationController

  def index

  end

  def show

  end

  def new
    @payment = Payment.new
  end

  def create
    payment = Payment.new(payment_params)
    if payment.save
      current_user.grant "pro_user"
      flash[:alert] = "You are now a premium user"
      redirect_to messages_home_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:card_number, :card_name, :date_exp, :code)
  end
end
