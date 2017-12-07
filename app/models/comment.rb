# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  default_scope -> { order(created_at: :desc) }

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end
