# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @images = current_user.feed.paginate(page: params[:page], per_page: 5) if user_signed_in?
  end

  def popular_images
    @images = Image.all.paginate(page: params[:page], per_page: 20)
  end

  def last_comments
    @comments = Comment.all.paginate(page: params[:page], per_page: 20)
  end
end
