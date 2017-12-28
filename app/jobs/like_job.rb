class LikeJob < ApplicationJob
  queue_as :default

  def perform(like_count, current_user)
    ActionCable.server.broadcast('image', count: like_count, name: current_user.name)

  end
end
