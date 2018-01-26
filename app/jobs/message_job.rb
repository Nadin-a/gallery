# frozen_string_literal: true

class MessageJob < ApplicationJob
  queue_as :chats

  def perform(message)
    room_param = message.room.id
    ActionCable.server.broadcast('room', message: render_message(message), room: room_param)
  end

  private

  def render_message(message)
    ApplicationController.render partial: 'messages/message', locals: { message: message }
  end
end
