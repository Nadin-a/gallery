require 'spec_helper'

describe 'image_features' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category, owner: @user)
    @image = FactoryBot.create(:random_image, category: @category)
  }

  before {
    login(@user)
    visit category_image_path(@category, @image)
  }

  comment = Faker::Lorem.sentence

  feature 'Creating comment' do
    scenario 'with valid parameters', js: true do
      fill_in 'New comment...', with: comment
      click_button 'Post'
      expect(page).to have_content(comment)
    end
  end

end