# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :owner, optional: true, foreign_key: :owner_id, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :images, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :owner, presence: true

  def self.default_scope
    order(created_at: :desc)
  end

  def self.ordered_by_popularity
    unscoped.select('categories.*, count(images.id) AS images_count').joins(:images).group(:id).order('images_count desc')
  end
end
