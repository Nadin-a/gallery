# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show followers popular]
  before_action :set_category, only: %i[show update destroy subscribe unsubscribe followers]

  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 15)
    authorize @categories
  end

  def show
    @images = @category.images.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit; end

  def create
    category = current_user.owned_categories.build(categories_params)
    authorize category
    if category.save
      redirect_to category, flash: { success: t(:category_created) }
    else
      redirect_to owned_categories_path, flash: { error: category.errors.full_messages }
    end
  end

  def update
    if @category.update(categories_params)
      flash[:success] = t(:category_updated)
    else
      flash[:error] = @category.errors.full_messages
    end
    redirect_to @category
  end

  def destroy
    if current_user.owned_categories.destroy @category
      flash[:success] = t(:category_deleted)
    else
      flash[:error] = t(:category_not_deleted)
    end
    redirect_to owned_categories_path
  end

  def owned
    @categories = current_user.owned_categories.paginate(page: params[:page], per_page: 15)
    authorize @categories
  end

  def favorite
    @categories = current_user.categories.paginate(page: params[:page], per_page: 15)
    authorize @categories
  end

  def popular
    @popular_categories = Category.ordered_by_popularity
  end

  def subscribe
    current_user.categories << @category
    current_user.send_email_about_subscribtion
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

  def followers
    @users = @category.users.paginate(page: params[:page], per_page: 20)
  end

  private

  def categories_params
    params.require(:category).permit(:name, :cover)
  end

  def set_category
    @category = Category.friendly.find(params[:id])
    authorize @category
  end
end
