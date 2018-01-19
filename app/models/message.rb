# frozen_string_literal: true

class Message < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user
  belongs_to :room

  validates :user, presence: true
  validates :room, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  after_create_commit { MessageJob.perform_later(self) }
end
