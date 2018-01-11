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
    it 'with successful message', js: true do
      fill_in 'New comment...', with: comment
      click_button 'Post'
      expect(page).to have_content('Comment created!')
    end
    it 'with empty content', js: true do
      fill_in 'New comment...', with: ''
      click_button 'Post'
      expect(page).to have_content("Content can't be blank")
    end
    it 'with long content', js: true do
      fill_in 'New comment...', with: 'a' * 301
      click_button 'Post'
      expect(page).to have_content('Content is too long (maximum is 300 characters')
    end
  end
end
