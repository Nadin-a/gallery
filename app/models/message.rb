# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { MessageJob.perform_later(self) }

  validates :user, presence: true
  validates :room, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  def self.default_scope
    order(created_at: :asc)
  end
end
