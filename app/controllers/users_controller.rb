# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user, only: %i[show destroy read_all toggle_receiving]

  def index
    @users = User.active.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def read_all
    @notifications = current_user.notifications.last(7).reverse
    current_user.read_all
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
