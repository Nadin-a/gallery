class LikeJob < ApplicationJob
  queue_as :default

  def perform(url, like_count, current_user)
    ActionCable.server.broadcast('image', url: url, count: like_count, name: current_user.name)
  end
end
