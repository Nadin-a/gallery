# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, expect: %i[index show]

  def index
    @categories = Category.all
  end

  def show
    @category = find_category
  end

  def new
    @category = Category.new
  end

  def edit
    @category = find_category
    unless current_user == @category.owner
     redirect_to root_path
    end
  end

  def update
    @category = find_category
    if @category.update(categories_params)
      flash[:success] = 'Category updated'
      redirect_to @category
    else
      render 'edit'
    end
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
    @category = find_category
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
    @category = find_category
    current_user.categories << @category
    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render :show, status: :created }
    end
  end

  def unsubscribe
    @category = find_category
    current_user.categories.delete(@category)
    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render :show, status: :created }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def categories_params
    params.require(:category).permit(:name)
  end

  def find_category
    Category.find(params[:id])
  end
end
