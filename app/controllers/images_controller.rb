# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_category
  before_action :set_image, except: %i[new create]
  before_action :authenticate_user!, except: %i[show]
  # before_action :correct_user, except: %i[show]

  def show
    @comment = current_user.comments.build if user_signed_in?
    @comments = @image.comments.paginate(page: params[:page], per_page: 10)
  end

  def new
    @image = @category.images.build
  end

  def create
    @image = @category.images.build(image_create_params)
    if @image.save
      flash[:success] = 'Image uploaded'
      redirect_to category_path(@category)
    else
      flash[:error] = @image.errors.full_messages
      render 'new'
    end
  end

  def edit; end

  def update
    if @image.update(image_update_params)
      flash[:success] = 'Image updated'
      redirect_to category_image_path(@category, @image)
    else
      flash[:error] = @image.errors.full_messages
      render 'edit'
    end
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
  def image_create_params
    params.require(:image).permit(:title, :description, :picture)
  end

  def image_update_params
    params.require(:image).permit(:title, :description)
  end

  def set_image
    @image = @category.images.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end