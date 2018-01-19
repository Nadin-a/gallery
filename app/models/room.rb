# frozen_string_literal: true

class Room < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { order(created_at: :desc) }

  belongs_to :user, optional: true, foreign_key: :user_id, class_name: 'User'
  has_many :messages, dependent: :destroy, class_name: 'Message'

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :user, presence: true

  def self.random_room
    unscoped.order('RANDOM()').sample
  end
end
