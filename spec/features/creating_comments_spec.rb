# frozen_string_literal: true

require 'spec_helper'
describe 'image_features', type: :feature do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category, owner: @user)
    @image = FactoryBot.create(:random_image, category: @category)
  end

  before do
    login(@user)
    visit category_image_path(@category, @image)
  end

  comment = Faker::Lorem.sentence

  describe 'Creating comment' do
    it 'with valid parameters', js: true do
      fill_in 'New comment...', with: comment
      click_button 'Post'
      expect(page).to have_content(comment)
    end
  end
end
