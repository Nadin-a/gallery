# frozen_string_literal: true

require 'spec_helper'
describe 'Find', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }

  before { login(user) }

  describe 'on main page' do
    it 'content_instead_carousel', js: true do
      visit root_path
      click_link 'Sign out'
      expect(page).to have_content('No images on site')
    end

    it 'content_instead_carousel_user_login', js: true do
      expect(page).to have_content('You have not any images.
      Subscribe on any category or add own image and you will see it here!')
    end
  end

  describe 'other pages', js: true do
    it 'content on my categories' do
      visit owned_categories_path
      expect(page).to have_content('My categories')
    end

    it 'content on favorite categories' do
      visit favorite_categories_path
      expect(page).to have_content('Favorite categories')
    end

    it 'content on all categories top 5' do
      visit categories_path
      expect(page).to have_content('TOP 5')
    end

    it 'content on all categories' do
      visit categories_path
      expect(page).to have_content('All categories')
    end
  end

end
