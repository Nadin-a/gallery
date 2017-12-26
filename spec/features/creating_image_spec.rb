# frozen_string_literal: true

require 'spec_helper'
describe 'image_features' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:fake_category, owner: @user)
    @image = FactoryBot.create(:random_image, category: @category)
  }

  before {
    login(@user)
    visit category_path(@category)
    click_link 'Add image'
  }

  image_title = Faker::Lorem.word
  new_image_title = Faker::Lorem.word

  describe 'Creating image' do
    it 'with valid parameters', js: true do
      fill_in 'Title of the picture', with: image_title
      fill_in 'Description of the picture', with: 'my description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Image uploaded')
      expect(page).to have_css("img[src*='test_picture.jpg']")
      visit category_image_path(@category, Image.first)
      expect(page).to have_content(image_title)
      expect(page).to have_content('my description')
      expect(page).to have_css("img[src*='test_picture.jpg']")
    end

    it 'without title', js: true do
      fill_in 'Title of the picture', with: ''
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content("Title can't be blank")
    end

    it 'with long title', js: true do
      fill_in 'Title of the picture', with: 'a' * 31
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Title is too long (maximum is 30 characters)')
    end

    it 'with long description', js: true do
      fill_in 'Title of the picture', with: image_title
      fill_in 'Description of the picture', with: 'a'*301
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Description is too long (maximum is 300 characters)')
    end

    it 'without uploading picture', js: true do
      fill_in 'Title of the picture', with: image_title
      click_button 'Add'
      expect(page).to have_content("Picture can't be blank")
    end
  end

  describe 'Updating image' do

    before {
      visit category_image_path(@category, @image)
      click_link 'Update'
    }

    it 'with valid parameters', js: true do
      fill_in 'Title of the picture', with: new_image_title
      fill_in 'Description of the picture', with: 'my new description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Update'
      expect(page).to have_content(new_image_title)
    end

    it 'with invalid patameters', js: true do
      fill_in 'Title of the picture', with: ''
      fill_in 'Description of the picture', with: ''
      click_button 'Update'
      expect(page).to have_content("Title can't be blank")
    end
  end

  describe 'Deleting image' do

    before {
      visit category_image_path(@category, @image)
    }

    it 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content('Image deleted!')
    end

  end
end
