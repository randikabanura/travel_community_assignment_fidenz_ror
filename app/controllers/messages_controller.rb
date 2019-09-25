class MessagesController < ApplicationController

  def index
    @messages = Message.all
    @new_message = Message.new
  end
end
