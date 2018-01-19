# frozen_string_literal: true

class Image < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope { order(created_at: :desc) }

  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :category, :picture, presence: true
  validates :title, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :description, length: { maximum: 300 }
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  def self.ordered_by_likes
    unscoped
    .select('images.*, count(likes.id) AS likes_count')
    .joins(:likes)
    .group('images.id')
    .order('likes_count desc')
  end

  def liked_by?(user)
    liking_users.include? user
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > 50.megabytes
    errors.add(:picture, I18n.t('size_error', size: '50MB'))
  end
end
