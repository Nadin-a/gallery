# frozen_string_literal: true

class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    p '-------------------------'
    p params
    stream_from 'room'
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el['name']] = el['value']
    end
    Message.create(message_params)
  end
end
