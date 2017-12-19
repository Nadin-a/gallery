require 'spec_helper'

feature 'Creating image' do

  let!(:image_title) { Faker::Lorem.word }
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category, owner: @user)
  }

  before {
    login(@user)
    visit category_path(@category)
    click_link 'Add image'
  }

  scenario 'can upload image', js: true do
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

  scenario 'can create a image without title', js: true do
    fill_in 'Title', with: ''
    attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
    click_button 'Add'
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'can create a image with long title', js: true do
    fill_in 'Title', with: 'a' * 31
    attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
    click_button 'Add'
    expect(page).to have_content('Title is too long (maximum is 30 characters)')
  end

  scenario 'can create a image with long description', js: true do
    fill_in 'Title', with: image_title
    fill_in 'Description', with: 'a'*141
    attach_file('uploaded_picture', Rails.root + 'spec/fixtures/test_picture.jpg')
    click_button 'Add'
    expect(page).to have_content('Description is too long (maximum is 140 characters)')
  end

  scenario 'can create a image without uploading picture', js: true do
    fill_in 'Title', with: image_title
    click_button 'Add'
    expect(page).to have_content("Picture can't be blank")
  end

end