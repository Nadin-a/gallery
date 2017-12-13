require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:user){FactoryBot.create(:user)}
  let!(:category) { FactoryBot.create(:category, owner: user) }
  let(:uncorrect_category) { FactoryBot.build(:uncorrect_category) }
  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to eq ''
    end

  end
  describe 'GET #show' do
    it 'show category' do
      get :show, params: {id: category.id}
      expect(assigns(:category)).to eq(category)
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        category = FactoryBot.build(:random_category)
        expect {
          post :create, params: {category: category.attributes}
        }.to change(Category, :count).by(1)
      end

      it 'redirect to a new category' do
        category = FactoryBot.build(:random_category)
        post :create, params: {category: category.attributes}
        expect(response).to redirect_to(Category.first)
        expect(response.status).to eq(302)
      end
    end

    context 'with invalid attributes' do # add redirect with login
      it 'does not save the new category' do
        expect {
          post :create, params: {category: uncorrect_category.attributes}
        }.to_not change(Category, :count)
      end
    end
  end

  describe 'PUT update' do
    context 'valid attributes' do
      it 'located the requested category' do
        category_params = { id: category.id, category: { name: 'Houses' } }
        expect {
          put :update, params: category_params
        }.to change { category.reload.name }.from('Cars').to('Houses')
        #expect(category.reload.name).to eq(category_params[:category][:name])
        #expect(response).to redirect_to(category)
      end

      it "redirects to the updated category" do
        category_params = { id: category.id, category: { name: 'Houses' } }
        put :update, params: category_params
        expect(response).to redirect_to(category)
      end

    end
  end
end
