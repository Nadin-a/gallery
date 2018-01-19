# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order(created_at: :desc) }

  belongs_to :owner, optional: true, foreign_key: :owner_id, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :owner, presence: true
  validate :cover_size

  mount_uploader :cover, CoverUploader

  def self.ordered_by_popularity
    popular_categories = Category.all.sort_by do |category|
      count = 0
      count += category.images.count
      category.images.each do |imgage|
        count += imgage.comments.count
        count += imgage.likes.count
      end
      count
    end
    popular_categories.last(5).reverse
  end

  def subscriber?(user)
    user.categories.include? self
  end

  private

  def cover_size
    return unless cover.size > 10.megabytes
    errors.add(:cover, 'should be less than 10MB')
  end
end
