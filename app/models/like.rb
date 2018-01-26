# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :user, :image, presence: true

  after_commit :send_like, on: %i[create destroy]

  private

  def send_like
    LikeJob.perform_later(image.id, image.likes.count)
  end
end
