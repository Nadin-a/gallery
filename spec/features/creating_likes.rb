# frozen_string_literal: true

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

  describe 'Like and dislike' do
    scenario 'opened image', js: true do
      find('#like').click
      expect(page).to have_content('1')
      find('#like').click
      expect(page).to have_content('0')
    end
  end
end
