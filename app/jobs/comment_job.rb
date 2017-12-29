# frozen_string_literal: true

class CommentJob < ApplicationJob
  queue_as :default

  def perform(url, comment, author, date)
    ActionCable.server.broadcast('image', url: url, comment: comment, author: author, date: date)
  end
end
