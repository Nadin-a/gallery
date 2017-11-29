# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
  end
end
