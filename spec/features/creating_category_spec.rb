# frozen_string_literal: true

require 'spec_helper'
describe 'category_features', type: :feature do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:fake_category, owner: @user)
  end

  before { login(@user) }
  category_name = Faker::Lorem.word

  describe 'Creating category' do
    it 'with valid parameters', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: category_name
      click_button 'Create'
      expect(page).to have_content(@user.name, category_name, 'Add image | Update | Delete')
    end

    it 'in owned categories', js: true do
      visit owned_categories_path
      expect(page).to have_content(category_name)
    end

    it 'with empty name', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: ''
      click_button 'Create'
      expect(page).to have_content('All categories', "Name can't be blank")
    end

    it 'with long name', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: 'a' * 21
      click_button 'Create'
      expect(page).to have_content('All categories', 'Name is too long (maximum is 20 characters)')
    end
  end

  describe 'Updating category' do

    before { visit category_path(@category) }

    new_category_name = Faker::Lorem.word

    it 'with valid new parameters', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_category_name
      click_button 'Update'
      expect(page).to have_content(new_category_name)
    end

    it 'with empty name', js: true do
      click_link 'Update'
      fill_in 'Name', with: ''
      click_button 'Update'
      expect(page).to have_content("Name can't be blank")
    end

    it 'with long name', js: true do
      click_link 'Update'
      fill_in 'Name', with: 'a' * 21
      click_button 'Update'
      expect(page).to have_content('Name is too long (maximum is 20 characters')
    end
  end

  describe 'Deleting category' do
    before { visit category_path(@category) }

    new_category_name = Faker::Lorem.word

    it 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content(new_category_name)
    end
  end
end
