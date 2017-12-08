# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  def self.default_scope
    order(created_at: :desc)
  end
end
