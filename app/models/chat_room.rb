class ChatRoom < ApplicationRecord
  acts_as_chat message_class: 'Message', tool_call_class: 'ToolCall'
  belongs_to :user
  accepts_nested_attributes_for :messages
end
