class ChatController < ApplicationController
  layout "minimal"
  include Guest

  def show
    @chat_rooms = user.chat_rooms
    @current_chat_room = @chat_rooms.includes(:messages).order(:created_at).last || user.chat_rooms.create(name: "General Chat")
  end

  def user
    current_or_guest_user
  end
end
