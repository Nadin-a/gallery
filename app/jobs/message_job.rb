# frozen_string_literal: true

class MessageJob < ApplicationJob
  queue_as :default

  def perform(url, message)
    ActionCable.server.broadcast('room', url: url, message: render_message(message))
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end
