# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @images = current_user.feed.paginate(page: params[:page], per_page: 5) if user_signed_in?
  end
end
