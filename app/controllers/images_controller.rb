# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :set_category
  before_action :set_image, except: %i[new create]
  before_action :authenticate_user!, except: %i[show]

  def new; end

  def show
    track_action('watch image')
    @comments = @image.comments.last(5)
    return unless user_signed_in?
    @like =
      if @image.liked_by?(current_user)
        @image.likes.find_by(user_id: current_user)
      else
        current_user.likes.build
      end
  end

  def create
    image = @category.images.build(image_params)
    authorize image
    if image.save
      flash[:success] = t(:image_created)
      send_email image
    else
      flash[:error] = image.errors.full_messages
    end
    redirect_to category_path(@category)
  end

  def edit; end

  def update
    if @image.update(image_params)
      flash[:success] = t(:image_updated)
    else
      flash[:error] = @image.errors.full_messages
    end
    redirect_to category_image_path(@category, @image)
  end

  def destroy
    if @image.destroy
      flash[:success] = t(:image_deleted)
    else
      flash[:error] = @image.errors.full_messages
    end
    redirect_to @category
  end

  private

  def send_email(image)
    image.category.users.find_each do |user|
      user.send_email_about_new_image image.id
    end
  end

  def image_params
    params.require(:image).permit(:title, :description, :picture)
  end

  def set_image
    @image = @category.images.friendly.find(params[:id])
    authorize @image
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
    authorize @category
  end
end
