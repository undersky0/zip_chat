class Message < ApplicationRecord
  # broadcasts_refreshes

  belongs_to :chat_room
  belongs_to :user, optional: true

  validates :content, presence: true

  after_create_commit -> { broadcast_append_to chat_room, target: dom_id(chat_room, :messages),
    partial: "messages/message", locals: { message: self } }

  after_destroy_commit -> { broadcast_remove_to chat_room, target: dom_id(self) }
end
