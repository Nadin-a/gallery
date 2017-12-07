# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, presence: true
  validates :image, presence: true
end
