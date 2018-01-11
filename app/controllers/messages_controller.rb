# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_room
  before_action :authenticate_user!, only: %i[create]

  def create
    @message = current_user.messages.new(message_params)
    authorize @message
    @room.messages << @message
    if @message.save
       MessageJob.perform_later(room_path(@room), @message)
    else
      flash[:error] = @message.errors.full_messages.first
    end
    respond_to do |format|
      format.html { redirect_to @room }
      format.json { render @room, status: :created }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_room
    @room = Room.find(params[:room_id])
    authorize @room
  end
end
