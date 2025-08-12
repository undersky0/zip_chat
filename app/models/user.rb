class User < ApplicationRecord
  has_prefix_id :user

  include Accounts
  include Agreements
  include Authenticatable
  include Mentions
  include Notifiable
  include Searchable
  include Theme
  include Chats

  has_one_attached :avatar
  has_one :address, dependent: :destroy
  delegate :postcode, :postcode=, to: :address, allow_nil: true

  has_person_name

  validates :avatar, resizable_image: true
  validates :name, presence: true
end
