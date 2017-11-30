# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @category = Categories.all
  end

  def show; end

  def new
    @category = Categories.new(categories_params)
  end

  def create; end

  def destroy; end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def categories_params
    params.require(:category).permit(:name)
  end
end
