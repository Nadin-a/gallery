# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :owner, optional: true, foreign_key: :owner_id, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :owner, presence: true
  validate  :cover_size

  mount_uploader :cover, CoverUploader

  def self.default_scope
    order(created_at: :desc)
  end

  def self.ordered_by_popularity
    unscoped.select('categories.*, count(images.id) AS images_count').joins(:images).group(:id).order('images_count desc')
  end

  def has_subscriber? user
    user.categories.include? self
  end

  private

  def cover_size
    return unless cover.size > 10.megabytes
    errors.add(:cover, 'should be less than 10MB')
  end

end
