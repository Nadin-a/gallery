# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    category_param = comment.image.category.name.downcase.tr(' ', '-')
    image_param = comment.image.title.downcase.tr(' ', '-')
    ActionCable.server.broadcast('image', comment: render_comment(comment), category: category_param,
    image: image_param)
  end

  private

  def render_comment(comment)
    CommentsController.render partial: 'messages/comment', locals: { comment: comment }
  end
end
