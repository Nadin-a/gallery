# frozen_string_literal: true

require 'spec_helper'
describe 'category_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:fake_category, owner: user) }

  before { login(user) }

  describe 'Creating category' do
    category_name = 'cats'

    it 'with valid parameters', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: category_name
      click_button 'Create'
      expect(page).to have_content(category_name)
    end

    it 'with successful message', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: category_name
      click_button 'Create'
      expect(page).to have_content('Category created!')
    end
  end

  describe 'Updating category' do
    before { visit category_path(category) }

    new_category_name = Faker::Lorem.word

    it 'with valid new parameters', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_category_name
      click_button 'Update'
      expect(page).to have_content(new_category_name)
    end

    it 'with successful message', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_category_name
      click_button 'Update'
      expect(page).to have_content('Category updated!')
    end

    it 'with cover', js: true do
      click_link 'Update'
      fill_in 'Name', with: 'new name'
      attach_file('uploaded_cover', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Update'
      expect(page).to have_content('Category updated!')
    end
  end

  describe 'Deleting category' do
    before { visit category_path(category) }

    it 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('Category deleted!')
    end
  end
end
