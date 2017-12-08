# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy, class_name: 'Comment'
  has_many :users, through: :comments
  has_many :likes, dependent: :destroy, class_name: 'Like'
  has_many :liking_users, through: :likes, source: :user

  mount_uploader :picture, PictureUploader

  validates :category, presence: true
  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :description, length: { maximum: 240 }
  validates :picture, presence: true
  validate  :picture_size

  default_scope -> { order(updated_at: :desc) }

  def self.ordered_by_likes
    select('images.*, count(likes.id) AS likes_count').joins(:likes).group(:id).order('likes_count desc')
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > 50.megabytes
    errors.add(:picture, 'should be less than 50MB')
  end
end
