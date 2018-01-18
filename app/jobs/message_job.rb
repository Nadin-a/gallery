# frozen_string_literal: true

class MessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    room = message.room.name.downcase.gsub(' ', '-')
    ActionCable.server.broadcast('room', message: render_message(message), room: room)
  end

  private

  def render_message(message)
    ApplicationController.render partial: 'messages/message', locals: { message: message }
  end
end
