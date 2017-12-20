require 'spec_helper'

describe 'category_features' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:fake_category, owner: @user)
  }

  before {
    login(@user)
  }
  category_name = Faker::Lorem.word


  feature 'Creating category' do

    scenario 'with valid parameters', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: category_name
      click_button 'Create'
      expect(page).to have_content(@user.name)
      expect(page).to have_content(category_name)
      expect(page).to have_content('Add image | Update | Delete')
      visit owned_categories_path
      expect(page).to have_content(category_name)

      click_button 'Create own category'
      fill_in 'Name', with: category_name
      click_button 'Create'
      expect(page).to have_content('Name has already been taken')
    end


    scenario 'with empty name', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: ''
      click_button 'Create'
      expect(page).to have_content('All categories')
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'with long name', js: true do
      visit categories_path
      click_button 'Create own category'
      fill_in 'Name', with: 'a'*21
      click_button 'Create'
      expect(page).to have_content('All categories')
      expect(page).to have_content('Name is too long (maximum is 20 characters)')
    end
  end

  feature 'Updating category' do

    before {
      visit category_path(@category)
    }

    new_category_name = Faker::Lorem.word

    scenario 'with valid new parameters', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_category_name
      click_button 'Update'
      expect(page).to have_content(new_category_name)
      expect(page).not_to have_content(category_name)
    end

    scenario 'with empty name', js: true do
      click_link 'Update'
      fill_in 'Name', with: ''
      click_button 'Update'
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'with long name', js: true do
      click_link 'Update'
      fill_in 'Name', with: 'a'*21
      click_button 'Update'
      expect(page).to have_content('Name is too long (maximum is 20 characters')
    end
  end

  feature 'Deleting category' do

    before {
      visit category_path(@category)
    }

    new_category_name = Faker::Lorem.word

    scenario 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content(new_category_name)
    end
  end
end