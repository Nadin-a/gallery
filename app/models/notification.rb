# frozen_string_literal: true

class Notification < ApplicationRecord
  scope :not_readed, -> { where(readed: false) }
  scope :new_notifications_in_24, -> { unscoped.where(created_at: (Time.current - 24.hours)..Time.current) }

  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  validates :recipient, presence: true
  validates :type_of_notification, presence: true

  after_commit -> { NotificationJob.perform_later(self) }
end
