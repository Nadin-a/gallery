# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_category
  before_action :set_image
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @comment = @image.comments.build(comment_params)
    authorize @comment
    current_user.comments << @comment
    if @comment.save
      flash[:success] = 'Comment created!'
    else
      flash[:error] = @comment.errors.full_messages.first
    end
    redirect_to category_image_path(@category, @image)
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment deleted'
    else
      flash[:error] = @comment.errors.full_messages
    end
    redirect_to category_image_path(@category, @image)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_image
    @image = Image.find(params[:image_id])
    authorize @image
  end

  def set_category
    @category = Category.find(params[:category_id])
    authorize @category
  end

end