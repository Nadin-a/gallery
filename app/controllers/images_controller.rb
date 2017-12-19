# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_category
  before_action :set_image, except: %i[new create]
  before_action :authenticate_user!, except: %i[show]

  def new; end

  def show
    @comment = current_user.comments.build if user_signed_in?
    @comments = @image.comments.paginate(page: params[:page], per_page: 10)
    return unless user_signed_in?
    @like =
      if @image.liked_by?(current_user)
        @image.likes.find_by(user_id: current_user)
      else
        current_user.likes.build
      end
  end

  def create
    @image = @category.images.build(image_params)
    authorize @image
    if @image.save
      flash[:success] = 'Image uploaded'
    else
      flash[:error] = @image.errors.full_messages
    end
    redirect_to category_path(@category)
  end

  def edit; end

  def update
    if @image.update(image_params)
      flash[:success] = 'Image updated'
    else
      flash[:error] = @image.errors.full_messages
    end
    redirect_to category_image_path(@category, @image)
  end

  def destroy
    if @image.destroy
      flash[:success] = 'Image deleted'
    else
      flash[:error] = @image.errors.full_messages
    end
    redirect_to @category
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:title, :description, :picture)
  end

  def set_image
    @image = @category.images.find(params[:id])
    authorize @image
  end

  def set_category
    @category = Category.find(params[:category_id])
    authorize @category
  end
end
