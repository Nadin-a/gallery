class LikeJob < ApplicationJob
  queue_as :default

  def perform(like_count, current_user)
    ActionCable.server.broadcast("likes_#{current_user.id}", { count: like_count })
  end
end
