# frozen_string_literal: true

class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order(created_at: :desc) }
  scope :new_rooms_in_24, -> { unscoped.where(created_at: (Time.current - 24.hours)..Time.current) }

  belongs_to :user
  has_many :messages, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :user, presence: true

  def self.random_room
    unscoped.order('RANDOM()').sample
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end
end
