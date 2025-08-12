class MessagesController < ApplicationController
  include Guest
  before_action :set_chat_room

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
