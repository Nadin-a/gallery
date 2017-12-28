# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class LikesChannel < ApplicationCable::Channel
  # Вызывается, когда потребитель успешно
  # стал подписчиком этого канала
  def subscribed
    # image = Image.find(params[:id])
    # stream_for image
    p '===========1=LikesChannel'
    stream_from "likes_#{current_user.id}"
  end

  def unsubscribed
    p '==========1==LikesChannelUNSUBSCRIBED'
    stop_all_streams
  end
end
