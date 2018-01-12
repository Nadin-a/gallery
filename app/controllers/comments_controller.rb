# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_category
  before_action :set_image
  before_action :authenticate_user!, only: %i[create]
  include Recaptcha::Verify

  def create
    @comment = @image.comments.new(comment_params)
    authorize @comment
    if Rails.env.production?
      check_recaptcha
    else
      create_comment
    end

    redirect_to category_image_path(@category, @image)
  end

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

  def check_recaptcha
    if verify_recaptcha(model: @comment)
      create_comment
    else
      flash[:error] = @comment.errors.full_messages.first
    end
  end

  def create_comment
    current_user.comments << @comment
    if @comment.save
      flash[:success] = t(:comment_created)
      show_comment_to_all unless Rails.env.test?
    else
      flash[:error] = @comment.errors.full_messages.first
    end
  end

  def show_comment_to_all
    CommentJob.perform_later(category_image_path(@category, @image), @comment)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_image
    @image = Image.find(params[:image_id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end
