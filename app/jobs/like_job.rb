# frozen_string_literal: true

class LikeJob < ApplicationJob
  queue_as :default

  def perform(image_id, like_count)
    ActionCable.server.broadcast('image', image: image_id, count: like_count)
  end
end
