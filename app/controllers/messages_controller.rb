class MessagesController < ApplicationController
  # before_action :authenticate_user!
  include Guest
  before_action :set_chat_room

  # POST /chat_rooms/:chat_room_id/messages
  def create
    ChatResponse.call(message: message_params[:content], chat_room: @chat_room)
  end

  private

  def user
    current_or_guest_user
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:content).with_defaults(user: user)
  end
end
