# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :notification

  def perform(notification)
    recipient = notification.recipient
    ActionCable.server.broadcast("notifications:#{notification.recipient_id}",
                                 notification: render_notification(notification),
                                 counter: recipient.notifications.where(readed: false).count)
  end

  private

  def render_notification(notification)
    ApplicationController.render partial: 'notifications/notification', locals: { notification: notification }
  end
end
