class ChatInterfaceController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = current_user.chat_rooms
    @current_chat_room = @chat_rooms.order(:created_at).last || current_user.chat_rooms.create(name: "General Chat")
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.includes(:user).order(:created_at)
    @message = Message.new
  end
end
