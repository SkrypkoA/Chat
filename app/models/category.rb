class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_many :pictures, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :users, through: :user_categories
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  default_scope  { order(:name) }

end
