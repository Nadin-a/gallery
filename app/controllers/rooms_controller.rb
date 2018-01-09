# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, only: %i[show]

  def index
    @room = Room.new
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.owned_rooms.build(room_params)
    if @room.save
      flash[:success] = 'Chat room added!'
      redirect_to rooms_path
    else
      render 'new'
    end
  end

  def show
    @message = current_user.messages.build if user_signed_in?
    @messages = @room.messages
  end
  
  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end