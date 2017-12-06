# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :set_image

  def create
    @like = @image.likes.build(like_params)
    current_user.likes << @image
    if @like.save
      respond_to do |format|
        format.html { redirect_to @like }
        format.json { render @image, status: :created }
      end
    end
  end

  def destroy;
  end

  private

  def like_params
    params.require(:comment).permit(:image_id)
  end

  def set_image
    @image = Image.find(params[:image_id])
  end

end