class ToolCall < ApplicationRecord
  acts_as_tool_call message_class: 'Message'
  belongs_to :message
end
