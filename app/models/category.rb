# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :owner, optional: true, foreign_key: :owner_id, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :owner, presence: true
end
