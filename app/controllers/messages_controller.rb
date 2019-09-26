class MessagesController < ApplicationController
  before_action :pro_user_authentication

  def index
    @messages = Message.custom_display
    @message = Message.new
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast "messages_channel", update_message: message_render(message)
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
    if !current_user.has_role? :pro_user
      flash[:alert] = "You have to be paid user to access message funcationality"
      redirect_to root_path
    end
  end
end
