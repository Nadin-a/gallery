# frozen_string_literal: true

require 'spec_helper'
describe 'category_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:fake_category, owner: user) }
  let!(:second_category) { FactoryBot.create(:fake_category, owner: user) }

  before { login(user) }

  describe 'Creating category' do
    before { visit categories_path }
    category_name_cats = 'cats'

    it 'with valid parameters', js: true do
      click_button 'Create own category'
      fill_in 'Name', with: category_name_cats
      click_button 'Create'
      expect(page).to have_content(category_name_cats)
    end

    it 'with successful message', js: true do
      click_button 'Create own category'
      fill_in 'Name', with: category_name_cats
      click_button 'Create'
      expect(page).to have_content('Category created!')
    end

    it 'with error message when category with same name exist', js: true do
      click_button 'Create own category'
      fill_in 'Name', with: category.name
      click_button 'Create'
      expect(page).to have_content('Name has already been taken')
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

    it 'with error message when category with same name exist', js: true do
      click_link 'Update'
      fill_in 'Name', with: second_category.name
      click_button 'Update'
      expect(page).to have_content('Name has already been taken')
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
