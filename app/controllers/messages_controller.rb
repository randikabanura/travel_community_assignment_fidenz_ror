class MessagesController < ApplicationController
  before_action :pro_user_authentication

  def index
    @messages = Message.custom_display
    @message = Message.new
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    payment = Payment.find_by(user_id: current_user.id)
    if payment.message_count > 0
      payment.message_count -= 1 if payment.message_count > 0
      if payment.save
        if message.save
          ActionCable.server.broadcast "messages_channel", update_message: message_render(message)
        end
      end
    elsif payment.message_count == -1
        if message.save
          ActionCable.server.broadcast "messages_channel", update_message: message_render(message)
        end
    elsif payment.message_count == 0
      flash[:notice] = "You are out of messages"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end

  def pro_user_authentication
    if !current_user.has_role? :pro_user_1
    elsif !current_user.has_role? :pro_user_2
    elsif !current_user.has_role? :pro_user_3
    else
      flash[:alert] = "You have to be paid user to access message funcationality"
      redirect_to root_path
    end
  end
end
