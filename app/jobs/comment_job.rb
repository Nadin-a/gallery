# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    category = comment.image.category.name.downcase.gsub(' ', '-')
    image = comment.image.title.downcase.gsub(' ', '-')
    ActionCable.server.broadcast('image', comment: render_comment(comment), category: category,
    image: image)
  end

  private

  def render_comment(comment)
    CommentsController.render partial: 'messages/comment', locals: { comment: comment }
  end
end
