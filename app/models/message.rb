# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user, :room, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  after_create_commit { MessageJob.perform_later(self) }
end
