# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ImageChannel < ApplicationCable::Channel
  # Вызывается, когда потребитель успешно
  # стал подписчиком этого канала
  def subscribed
    # image = Image.find(params[:id])
    # stream_for image
   # stream_from "likes_#{current_user.id}"
   # stream_for current_user
    stream_from 'image'
  end

  def unsubscribed
    stop_all_streams
  end
end
