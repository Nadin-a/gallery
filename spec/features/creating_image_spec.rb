# frozen_string_literal: true

require 'spec_helper'
describe 'image_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:fake_category, owner: user) }
  let!(:image) { FactoryBot.create(:random_image, category: category) }

  before do
    login(user)
    visit category_path(category)
    click_link 'Add image'
  end

  image_title = Faker::Lorem.word
  new_image_title = Faker::Lorem.word

  describe 'Creating image' do
    it 'with valid parameters', js: true do
      fill_in 'Title of the picture', with: image_title
      fill_in 'Description of the picture', with: 'my description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_css("img[src*='test_picture.jpg']")
    end

    it 'with successful message', js: true do
      fill_in 'Title of the picture', with: image_title
      fill_in 'Description of the picture', with: 'my description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Image uploaded')
    end

    it 'without uploading picture', js: true do
      fill_in 'Title of the picture', with: image_title
      click_button 'Add'
      expect(page).to have_content("Picture can't be blank")
    end
  end

  describe 'Updating image' do
    before do
      visit category_image_path(category, image)
      click_link 'Update'
    end

    it 'with valid parameters', js: true do
      fill_in 'Title of the picture', with: new_image_title
      fill_in 'Description of the picture', with: 'my new description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Update'
      expect(page).to have_content(new_image_title)
    end

    it 'with successful message', js: true do
      fill_in 'Title of the picture', with: new_image_title
      fill_in 'Description of the picture', with: 'my new description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Update'
      expect(page).to have_content('Image updated')
    end
  end

  describe 'Deleting image' do
    before { visit category_image_path(category, image) }

    it 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('Image deleted')
    end
  end
end
