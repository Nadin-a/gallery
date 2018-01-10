class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    p '==========subscribed============='
    stream_from 'room'
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    # process data sent from the page
  end
end