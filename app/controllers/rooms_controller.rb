# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, except: %i[index new create]
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.all.paginate(page: params[:page], per_page: 5)
  end

  def new; end

  def create
    @room = current_user.owned_rooms.build(room_params)
    authorize @room
    if @room.save
      flash[:success] = t('room_created')
      redirect_to room_path(@room)
    else
      flash[:error] = @room.errors.full_messages
      redirect_to rooms_path
    end
  end

  def show
    @message = current_user.messages.build if user_signed_in?
    @messages = @room.messages.last(8)
  end

  def edit; end

  def update
    authorize @room
    if @room.update(room_params)
      flash[:success] = t('room_updated')
    else
      flash[:error] = @room.errors.full_messages
    end
    redirect_to @room
  end

  def destroy
    if @room.destroy
      flash[:success] = t('room_deleted')
    else
      flash[:error] = t('room_not_deleted')
    end
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.friendly.find(params[:id])
    authorize @room
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
