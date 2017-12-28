# frozen_string_literal: true

class LikeJob < ApplicationJob
  queue_as :default

  def perform(url, like_count)
    ActionCable.server.broadcast('image',{ url: url, count: like_count })
  end
end
