# frozen_string_literal: true

require 'spec_helper'
describe 'image_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:random_category, owner: user) }
  let!(:image) { FactoryBot.create(:random_image, category: category) }

  before do
    login(user)
    visit category_image_path(category, image)
  end

  comment = Faker::Lorem.sentence

  describe 'Creating comment' do
    it 'with valid parameters', js: true do
      fill_in 'New comment...', with: comment
      click_button 'Post'
      expect(page).to have_content(comment)
    end
  end
end
