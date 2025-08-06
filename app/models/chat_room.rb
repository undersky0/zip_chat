class ChatRoom < ApplicationRecord
  broadcasts_refreshes
  has_many :messages, dependent: :destroy
end
