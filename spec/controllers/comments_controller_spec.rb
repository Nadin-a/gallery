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
