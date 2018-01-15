# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast('image', comment: render_comment(comment), category: comment.image.category.id,
    image: comment.image.id)
  end

  private

  def render_comment(comment)
    CommentsController.render partial: 'messages/comment', locals: { comment: comment }
  end
end
