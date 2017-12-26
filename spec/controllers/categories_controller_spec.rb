# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:category, owner: user) }
  let(:uncorrect_category) { FactoryBot.build(:uncorrect_category) }
  let!(:image) { FactoryBot.create(:image, category: category) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #owned' do
    it 'renders the :owned view' do
      get :owned
      expect(response).to render_template('owned')
    end
  end

  describe 'GET #favorite' do
    it 'renders the :favorite view' do
      get :favorite
      expect(response).to render_template('favorite')
    end
  end

  describe 'GET #show' do
    it 'show category' do
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end

    it 'render show' do
      get :show, params: { id: category.id }
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        category = FactoryBot.build(:random_category)
        expect {
          post :create, params: { category: category.attributes }
        }.to change(Category, :count).by(1)
      end

      it 'redirect to a new category' do
        category = FactoryBot.build(:random_category)
        post :create, params: { category: category.attributes }
        expect(response).to redirect_to(Category.first)
      end

      it 'show succesful message' do
        category = FactoryBot.build(:random_category)
        post :create, params: { category: category.attributes }
        expect(flash[:success]).not_to be_nil
      end

    end

    context 'with invalid attributes' do
      it 'does not save the new category' do
        expect {
          post :create, params: { category: uncorrect_category.attributes }
        }.not_to change(Category, :count)
      end

      it 'does not save the new category and show error message' do
        post :create, params: { category: uncorrect_category.attributes }
        expect(flash[:error]).not_to be_nil
      end
    end

    describe 'POST #subscribe' do
      before { sign_in(second_user) }
      it 'subscribe category' do
        post :subscribe, params: { id: category.id }, format: :json
        expect(second_user.categories.count).to eq 1
      end

      it 'unsubscribe category' do
        delete :unsubscribe, params: { id: category.id }, format: :json
        expect(second_user.categories.count).to eq 0
      end
    end
  end

  describe 'PUT update' do
    let(:category_params) { { id: category.id, category: { name: 'Houses' } } }
    let(:invalid_category_params) { { id: category.id, category: { name: '' } } }

    context 'valid attributes' do
      it 'located the requested category' do
        expect {
          put :update, params: category_params
        }.to change { category.reload.name }.from('Cars').to('Houses')
      end

      it 'redirects to the updated category' do
        put :update, params: category_params
        expect(response).to redirect_to(category)
      end

      it 'show successful message' do
        put :update, params: category_params
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'invalid attributes' do
      it 'can`t update category' do
        put :update, params: invalid_category_params
        expect(response).not_to be_success
      end

      it 'redirect to index' do
        put :update, params: invalid_category_params
        expect(response).to redirect_to(category)
      end

      it 'show error message' do
        put :update, params: invalid_category_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'delete the category' do
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to owned_categories' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to owned_categories_path
      expect(flash[:success]).not_to be_nil
    end

    it 'show successful message' do
      delete :destroy, params: { id: category.id }
      expect(flash[:success]).not_to be_nil
    end

    it 'delete with images' do
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Image, :count).by(-1)
    end
  end
end
