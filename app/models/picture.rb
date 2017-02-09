class Picture < ApplicationRecord
  mount_uploader :location, AvatarUploader
  #paginates_per 5
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :category
  belongs_to :user
  validates :location, presence: true
  default_scope  { order(likes_count: :desc, id: :asc) }

  after_save :add_picture_notification

  def add_picture_notification
    category.users.each do |user|
      UserMailer.add_picture_notification(user, self).deliver_now
    end
  end
end
