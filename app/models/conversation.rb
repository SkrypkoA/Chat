class Conversation < ApplicationRecord
  has_many :messages
  has_many :conversations_users, dependent: :destroy
  has_many :users, through: :conversations_users
end
