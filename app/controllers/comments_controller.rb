# frozen_string_literal: true

include Recaptcha::Verify
class CommentsController < ApplicationController
  before_action :set_category
  before_action :set_image
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @user = current_user
    @comment = @image.comments.new(comment_params)
    authorize @comment
    current_user.comments << @comment
    if @comment.save && verify_recaptcha(model: @comment, message: 'Please enter the correct captcha!')
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
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end
