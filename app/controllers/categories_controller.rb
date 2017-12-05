# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_category, except: %i[index new owned favorite create]

  def index
    @categories = Category.all
  end

  def show
    @images = @category.images.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def edit
    unless current_user == @category.owner
      redirect_to root_path
    end
  end

  def update
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
      redirect_to @category
    else
      render 'new'
    end
  end

  def destroy
    if current_user.owned_categories.destroy @category
      flash[:success] = 'Category deleted!'
    else
      flash[:error] = 'Category was not deleted!'
    end
    redirect_to categories_path
  end

  def owned
    @categories = current_user.owned_categories
  end

  def favorite
    @categories = current_user.categories
  end

  def subscribe
    current_user.categories << @category
    respond_to do |format|
      format.html { redirect_to @category }
      format.json { render :show, status: :created }
    end
  end

  def unsubscribe
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

  def set_category
    @category = Category.find(params[:id])
  end
end
