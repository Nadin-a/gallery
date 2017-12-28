# frozen_string_literal: true

# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ImageChannel < ApplicationCable::Channel
  def subscribed
    # image = Image.find(params[:id])
    # stream_for image
   # stream_from "likes_#{current_user.id}"
   # stream_for current_user
    stream_from 'image'
  end

  def unsubscribed
    stop_all_streams
  end
end
