# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, expect: %i[index show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.owned_categories.build(categories_params)
    if @category.save
      flash[:success] = 'Category created'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id]).destroy
    flash[:success] = 'Category deleted'
    redirect_to categories_path
  end

  def owned
    @categories = current_user.owned_categories
  end

  def favorite
    @categories = current_user.categories
  end

  def subscribe
    @category = Category.find(params[:id])
    current_user.categories << @category
    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render :show, status: :created }
    end
  end

  def unsubscribe
    @category = Category.find(params[:id])
    current_user.categories.delete(@category)
    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render :show, status: :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def categories_params
    params.require(:category).permit(:name)
  end

end
