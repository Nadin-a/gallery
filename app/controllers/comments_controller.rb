# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_category
  before_action :set_image
  before_action :authenticate_user!

  def destroy
    @comment = @image.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:success] = t(:comment_deleted)
    else
      flash[:error] = @comment.errors.full_messages
    end
    redirect_to category_image_path(@category, @image)
  end

  private

  def set_image
    @image = Image.friendly.find(params[:image_id])
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end
end
