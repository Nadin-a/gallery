# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show followers]
  before_action :set_category, except: %i[index new owned favorite create]
  before_action :set_new_category, only: %i[new index owned favorite]

  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 15)
    @popular_categories = Category.ordered_by_popularity
    authorize @categories
  end

  def show
    @image = @category.images.build
    @images = @category.images.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def new; end

  def edit; end

  def create
    @category = current_user.owned_categories.build(categories_params)
    authorize @category
    if @category.save
      flash[:success] = t(:category_created)
      redirect_to @category
    else
      flash[:error] = @category.errors.full_messages
      redirect_to categories_path
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
    authorize @category
  end

  def favorite
    @categories = current_user.categories.paginate(page: params[:page], per_page: 15)
    authorize @categories
  end

  def subscribe
    current_user.categories << @category
    respond_to do |format|
      current_user.send_email_about_subscribtion
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
    @category = Category.find(params[:id])
    authorize @category
  end

  def set_new_category
    @category = Category.new
    authorize @category
  end
end
