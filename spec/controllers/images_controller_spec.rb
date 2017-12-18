# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:random_category, owner: user) }
  let!(:image) { FactoryBot.create(:image, category: category) }
  let!(:invalid_image) { FactoryBot.build(:invalid_image, category: category) }
  let!(:like) { FactoryBot.create(:like, image: image, user: user) }
  let!(:comment) { FactoryBot.create(:comment, image: image, user: user) }

  before { sign_in(user) }

  describe 'GET #show' do
    it 'show image' do
      get :show, params: {category_id: category, id: image.id}
      expect(assigns(:image)).to eq(image)
    end

    it 'render show' do
      get :show, params: {category_id: category, id: image.id}
      expect(response).to render_template :show
    end

  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new image' do
        image = FactoryBot.build(:random_image)
        p image
        expect {
          post :create, params: {category_id: category, image: image.attributes}
        }.to change(Image, :count).by(1)
      end

      it 'redirect to a new image' do
        image = FactoryBot.build(:random_image)
        post :create, params: {category_id: category, image: image.attributes}
        expect(response.status).to eq(302)
        expect(flash[:success]).to_not be_nil
      end
    end

    context 'with invalid attributes' do # add redirect with login
      it 'does not save the new image' do
        expect {
          post :create, params: {category_id: category, image: invalid_image.attributes}
        }.to_not change(Image, :count)
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'PUT update' do
    let(:image_params) { {id: image.id, category_id: category, image: {title: 'new_image_title'}} }
    let(:invalid_image_params) { {id: image.id, category_id: category, image: {title: ''}} }

    context 'valid attributes' do
      it 'located the requested image' do
        expect {
          put :update, params: image_params
        }.to change { image.reload.title }.from('title').to('new_image_title')
      end

      it 'redirects to the updated image' do
        put :update, params: image_params
        expect(response).to redirect_to(category_image_path(category, image))
        expect(flash[:success]).to_not be_nil
      end
    end

    context 'invalid attributes' do
      it 'can`t update category' do
        put :update, params: invalid_image_params
        expect(response).to_not be_success
        expect(flash[:error]).to_not be_nil
      end

      it 'redirect to show' do
        put :update, params: invalid_image_params
        expect(response).to redirect_to(category_image_path(category, image))
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'delete the image' do
      expect {
        delete :destroy, params: {category_id: category, id: image.id}
      }.to change(Image, :count).by(-1)
    end

    it 'redirects to category' do
      delete :destroy, params: {category_id: category, id: image.id}
      expect(response).to redirect_to category
      expect(flash[:success]).to_not be_nil
    end

    it 'delete with comments and likes' do
      expect {
        delete :destroy, params: {category_id: category, id: image.id}
      }.to change(Comment, :count).by(-1) and change(Like, :count).by(-1)
    end
  end
end