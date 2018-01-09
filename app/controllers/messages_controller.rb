# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_room
  before_action :authenticate_user!, only: %i[create]

  def create
    @message = current_user.messages.new(message_params) if user_signed_in?
    @room.messages << @message
    if @message.save
      # LikeJob.perform_later(category_image_path(@category, @image), @image.likes.count)
    else
      flash[:error] = @message.errors.full_messages.first
    end
    redirect_to room_path(@room)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
