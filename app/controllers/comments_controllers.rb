class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :correct_user, only: :destroy
  before_action :set_image, except: %i[new]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment created!'
    else
      # @feed_items = []
    end
    redirect_to @image
  end

  def destroy
    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to @image
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_image
    @image = Image.find_by_id(params[:id])
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end