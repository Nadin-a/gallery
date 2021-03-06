# frozen_string_literal: true

# Be sure to restart your server when you modify this file.
class ImageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'image'
  end

  def unsubscribed
    stop_all_streams
  end

  def send_comment(data)
    comment_params = data['comment'].each_with_object({}) do |el, hash|
      hash[el['name']] = el['value']
    end
    Comment.create(comment_params)
  end
end
