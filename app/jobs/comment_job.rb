# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(url, comment)
    ActionCable.server.broadcast('image', url: url, comment: render_comment(comment))
  end

  private

  def render_comment(comment)
    CommentsController.render partial: 'messages/comment', locals: {comment: comment}
  end

end
