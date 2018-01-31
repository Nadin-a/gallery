# frozen_string_literal: true

class Image < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  default_scope { order(created_at: :desc) }
  scope :new_images_in_24, -> { unscoped.where(created_at: (Time.current - 24.hours)..Time.current) }

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

  def should_generate_new_friendly_id?
    title_changed?
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  def self.copy_image(attr, new_category_id, picture)
    attr['title'] = attr['title'][0...-5] if attr['title'].length + 5 > 20
    if Rails.env.production?
      Image.create!(title: Faker::Number.number(5).to_s + attr['title'], category_id: new_category_id,
                    remote_picture_url: picture.url,
                    description: attr['description'])
    else
      Image.create!(title: Faker::Number.number(5).to_s + attr['title'], category_id: new_category_id,
                    picture: File.new(picture),
                    description: attr['description'])
    end
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > 50.megabytes
    errors.add(:picture, I18n.t('size_error', size: '50MB'))
  end
end
