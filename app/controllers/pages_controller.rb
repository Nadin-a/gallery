# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @images =
      if user_signed_in?
        current_user.feed
      else
        Image.all
      end
  end

  def popular_images
    @images = Image.ordered_by_likes.paginate(page: params[:page], per_page: 20)
  end

  def last_comments
    @comments = Comment.all.paginate(page: params[:page], per_page: 20)
  end
end
