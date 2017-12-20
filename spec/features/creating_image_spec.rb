require 'spec_helper'

describe 'image_features' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category, owner: @user)
    @image = FactoryBot.create(:random_image, category: @category)
  }

  before {
    login(@user)
    visit category_path(@category)
    click_link 'Add image'
  }

  image_title = Faker::Lorem.word
  new_image_title = Faker::Lorem.word

  feature 'Creating image' do
    scenario 'with valid parameters', js: true do
      fill_in 'Title', with: image_title
      fill_in 'Description', with: 'my description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Image uploaded')
      expect(page).to have_css("img[src*='test_picture.jpg']")
      visit category_image_path(@category, Image.first)
      expect(page).to have_content(image_title)
      expect(page).to have_content('my description')
      expect(page).to have_css("img[src*='test_picture.jpg']")
    end

    scenario 'without title', js: true do
      fill_in 'Title', with: ''
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content("Title can't be blank")
    end

    scenario 'with long title', js: true do
      fill_in 'Title', with: 'a' * 31
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Title is too long (maximum is 30 characters)')
    end

    scenario 'with long description', js: true do
      fill_in 'Title', with: image_title
      fill_in 'Description', with: 'a'*301
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Add'
      expect(page).to have_content('Description is too long (maximum is 300 characters)')
    end

    scenario 'without uploading picture', js: true do
      fill_in 'Title', with: image_title
      click_button 'Add'
      expect(page).to have_content("Picture can't be blank")
    end
  end

  feature 'Updating image' do

    before {
      visit category_image_path(@category, @image)
      click_link 'Update'
    }

    scenario 'with valid parameters', js: true do
      fill_in 'Title', with: new_image_title
      fill_in 'Description', with: 'my new description'
      attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
      click_button 'Update'
      expect(page).to have_content(new_image_title)
      expect(page).not_to have_content(image_title)
    end

    scenario 'with invalid patameters', js: true do
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
      click_button 'Update'
      expect(page).to have_content("Title can't be blank")
    end
  end

  feature 'Deleting image' do

    before {
      visit category_image_path(@category, @image)
    }

    scenario 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content('hghgfhf')
    end

  end
end
