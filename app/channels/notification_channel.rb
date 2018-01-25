# frozen_string_literal: true

# Be sure to restart your server when you modify this file.
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
