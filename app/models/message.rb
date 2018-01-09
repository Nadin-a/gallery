# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user, presence: true
  validates :room, presence: true
  validates :content, presence: true, length: { maximum: 300 }

  def self.default_scope
    order(created_at: :asc)
  end
end
