# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template('index')
    end
    it 'have response' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'show category' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'render show' do
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end

    it 'have response' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(200)
    end
  end
end
