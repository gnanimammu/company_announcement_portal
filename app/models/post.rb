class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :user, presence: true
  has_many :comments
  # For handling image uploads (e.g., with ActiveStorage)
  has_one_attached :image
end
