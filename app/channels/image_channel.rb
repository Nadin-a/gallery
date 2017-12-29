# frozen_string_literal: true

# Be sure to restart your server when you modify this file.
class ImageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'image'
  end

  def unsubscribed
    stop_all_streams
  end
end
