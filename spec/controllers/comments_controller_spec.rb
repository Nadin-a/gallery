# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:random_category) }
  let!(:image) { FactoryBot.create(:image, category: category) }
  let!(:comment) { FactoryBot.create(:comment, image: image, user: user) }
  let!(:invalid_comment) { FactoryBot.build(:invalid_comment, image: image, user: user) }

  before { sign_in(user) }

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new comment' do
        comment = FactoryBot.build(:random_comment)
        expect {
          post :create, params: {category_id: category, image_id: image, comment: comment.attributes}
        }.to change(Comment, :count).by(1)
      end

      it 'redirect to commented image' do
        comment = FactoryBot.build(:random_comment)
        post :create, params: {category_id: category, image_id: image, comment: comment.attributes}
        expect(response).to redirect_to(category_image_path(category, image))
        expect(flash[:success]).to_not be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save with invalid attributes' do
        expect {
          post :create, params: {category_id: category, image_id: image, comment: invalid_comment.attributes}
        }.to_not change(Comment, :count)
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
