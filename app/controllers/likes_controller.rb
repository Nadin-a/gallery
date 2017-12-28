# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_category
  before_action :set_image
  before_action :set_like, only: :destroy
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @like = @image.likes.build
    authorize @like
    current_user.likes << @like
    return unless @like.save
    LikeJob.perform_later(category_image_path(@category, @image), @image.likes.count)
    respond_to do |format|
      format.html { redirect_to @image }
      format.json { render @image, status: :created }
    end
  end

  def destroy
    return unless @like.destroy
    LikeJob.perform_later(category_image_path(@category, @image), @image.likes.count)
    respond_to do |format|
      format.html { redirect_to @image }
      format.json { render @image, status: :created }
    end
  end

  private

  def set_like
    @like = @image.likes.find_by(user_id: current_user)
    authorize @like
  end

  def set_image
    @image = Image.find(params[:image_id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end
