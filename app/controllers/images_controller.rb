# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_category
  before_action :set_image, except: %i[index new]
  before_action :authenticate_user!, except: %i[index show]


  def index
    redirect_to home_path
  end

  def show; end

  def new
    @image = @category.images.build
  end

  def create
    @image = @category.images.build(image_create_params)
    if @image.save
      flash[:success] = 'Image uploaded'
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end

  def edit
    unless current_user == @category.owner
      redirect_to root_path
    end
  end

  def update
    if @image.update(image_update_params)
      flash[:success] = 'Image updated'
      redirect_to category_image_path(@category, @image)
    else
      render 'edit'
    end
  end

  def destroy
    @image.destroy
    flash[:success] = 'Image deleted'
    redirect_to @category
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_create_params
    params.require(:image).permit(:title, :picture)
  end

  def image_update_params
    params.require(:image).permit(:title, :description)
  end

  def set_image
    @image = Image.find_by_id(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end