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

  describe 'Like and dislike' do
    it 'like image', js: true do
      find('#like').click
      expect(page).to have_content('1')
    end

    it 'dislike image', js: true do
      find('#like').click
      expect(page).to have_content('0')
    end
  end
end
