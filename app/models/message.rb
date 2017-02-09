class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :conversation_id, presence: true
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end