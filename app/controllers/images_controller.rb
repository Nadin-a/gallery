# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_category
  before_action :set_image, except: %i[new]
  before_action :authenticate_user!, except: %i[show]
  before_action :correct_user, except: %i[show]

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

  def edit; end

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

  def correct_user
    set_image
    @category = current_user.owned_categories.find_by(id: @image.category_id)
    redirect_to root_url if @category.nil?
  end

end