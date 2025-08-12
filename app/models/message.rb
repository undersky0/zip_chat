class Message < ApplicationRecord
  # broadcasts_refreshes

  belongs_to :chat_room
  belongs_to :user, optional: true

  validates :content, presence: true

  after_create_commit :broadcast_message

  after_destroy_commit -> { broadcast_remove_to chat_room, target: dom_id(self) }

  private

  def broadcast_message
    broadcast_append_to chat_room,
                       target: "chat_room_#{chat_room.id}_messages",
                       partial: "messages/message",
                       locals: { message: self }
  end
end
