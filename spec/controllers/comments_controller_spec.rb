# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:admin_user) { FactoryBot.create(:admin) }
  let!(:category) { FactoryBot.create(:random_category) }
  let!(:image) { FactoryBot.create(:image, category: category) }
  let!(:comment) { FactoryBot.create(:comment, image: image, user: user) }
  let!(:invalid_comment) { FactoryBot.build(:invalid_comment, image: image, user: user) }

  before { sign_in(admin_user) }

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        comment = FactoryBot.build(:random_comment)
        expected = expect do
          post :create, params: { category_id: category, image_id: image, comment: comment.attributes }
        end
        expected.to change(Comment, :count).by(1)
      end

      it 'redirect to commented image' do
        comment = FactoryBot.build(:random_comment)
        post :create, params: { category_id: category, image_id: image, comment: comment.attributes }
        expect(response).to redirect_to(category_image_path(category, image))
      end

      it 'show succesful message' do
        comment = FactoryBot.build(:random_comment)
        post :create, params: { category_id: category, image_id: image, comment: comment.attributes }
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save with invalid attributes' do
        expected = expect do
          post :create, params: { category_id: category, image_id: image, comment: invalid_comment.attributes }
        end
        expected.not_to change(Comment, :count)
      end

      it 'show error message' do
        post :create, params: { category_id: category, image_id: image, comment: invalid_comment.attributes }
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'can delete comment' do
      expected = expect { delete :destroy, params: { category_id: category, image_id: image.id, id: comment } }
      expected.to change(Comment, :count).by(-1)
    end
    it 'show successful message' do
      delete :destroy, params: { category_id: category, image_id: image.id, id: comment }
      expect(flash[:success]).not_to be_nil
    end
  end
end

