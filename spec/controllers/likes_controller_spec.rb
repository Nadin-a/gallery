# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:random_category) }
  let!(:image) { FactoryBot.create(:image, category: category) }
  let!(:like) { FactoryBot.create(:like, image: image, user: user) }

  before { sign_in(user) }

  describe 'POST create' do
    it 'like' do
      like = FactoryBot.build(:like)
      expected = expect do
        post :create, params: { category_id: category, image_id: image, like: like.attributes }, format: :json
      end
      expected.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE destroy' do
    it 'dislike' do
      expected = expect do
        delete :destroy, params: { category_id: category, image_id: image.id, id: like }, format: :json
      end
      expected.to change(Like, :count).by(-1)
    end
  end
end
