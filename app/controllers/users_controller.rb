# frozen_string_literal: true

class PagesController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update; end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
  end


end