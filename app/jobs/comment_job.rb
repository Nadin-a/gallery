# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    ActionCable.server.broadcast('image', comment: render_comment(comment), image: comment.image.id,
      count: comment.image.likes.count)
  end

  private

  def render_comment(comment)
    CommentsController.render partial: 'messages/comment', locals: { comment: comment }
  end
end
