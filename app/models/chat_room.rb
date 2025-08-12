class ChatRoom < ApplicationRecord
  # broadcasts_refreshes - temporarily disabled to avoid conflicts
  has_many :messages, dependent: :destroy
  belongs_to :user
end
