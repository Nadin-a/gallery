# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 300 }

  def self.default_scope
    order(created_at: :asc)
  end
end
