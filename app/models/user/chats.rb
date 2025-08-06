module User::Chats
  extend ActiveSupport::Concern

  included do
    has_many :chat_rooms, dependent: :destroy
    has_many :messages, through: :chat_rooms
  end

end
