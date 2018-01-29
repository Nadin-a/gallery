# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order(created_at: :desc) }
  scope :new_categories_in_24, -> { unscoped.where(created_at: (Time.current - 24.hours)..Time.current) }

  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :owner, presence: true
  validate :cover_size

  mount_uploader :cover, CoverUploader

  def self.ordered_by_popularity
    unscoped
      .joins(images: %i[likes comments])
      .select('categories.*, (COUNT(images.id) + COUNT(comments.id) + COUNT(likes.id)) AS performance')
      .group('categories.id')
      .order('performance DESC')
      .limit(5)
  end

  def subscriber?(user)
    user.categories.include? self
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  private

  def cover_size
    return unless cover.size > 10.megabytes
    errors.add(:cover, I18n.t('size_error', size: '10MB'))
  end
end
