# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.where.not(confirmed_at:  nil).paginate(page: params[:page], per_page: 5)
  end

  def show;
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
