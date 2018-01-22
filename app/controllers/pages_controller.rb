# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :navigation

  def home
    @images =
      if user_signed_in?
        current_user.feed.paginate(page: params[:page], per_page: 20)
      else
        Image.all.paginate(page: params[:page], per_page: 20)
      end
  end

  def popular_images
    @images = Image.ordered_by_likes.paginate(page: params[:page], per_page: 20)
  end

  def last_comments
    @comments = Comment.last_comments.paginate(page: params[:page], per_page: 5)
  end

  def updates
    @images = Image.ordered_by_likes.first(24)
    @comments = Comment.last_comments.first(6)
  end

  private

  def navigation
    track_action('navigation')
  end
end
