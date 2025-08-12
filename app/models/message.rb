class Message < ApplicationRecord
  acts_as_message chat_class: 'ChatRoom', tool_call_class: 'ToolCall'
  belongs_to :chat_room
  belongs_to :user, optional: true

  after_create_commit :broadcast_message, if: :should_broadcast?
  after_update_commit :update_broadcast_message, if: :should_broadcast?
  after_destroy_commit -> { broadcast_remove_to chat_room, target: dom_id(self) }

  scope :without_system, -> { where.not(role: ["system"]) }

  private

  def system_message?
    role == "system"
  end

  def should_broadcast?
    !system_message?
  end

  def broadcast_message
    broadcast_append_to chat_room,
                       target: "chat_room_#{chat_room.id}_messages",
                       partial: "messages/message",
                       locals: { message: self }
  end

  def update_broadcast_message
    broadcast_replace_to chat_room,
                         target: dom_id(self),
                         partial: "messages/message",
                         locals: { message: self }
  end
end
