# frozen_string_literal: true

require 'spec_helper'
describe 'like_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:random_category, owner: user) }
  let!(:image) { FactoryBot.create(:random_image, category: category) }

  before do
    login(user)
    visit category_image_path(category, image)
  end

  describe 'Like and dislike' do
    it 'like image', js: true do
      find('#like').click
      expect(page).to have_content('1')
    end

    it 'dislike image', js: true do
      find('#like').click
      find('#like').click
      expect(page).to have_content('0')
    end

    it 'place image in popular', js: true do
      find('#like').click
      visit popular_images_path
      expect(page).not_to have_content('There are no popular pictures')
    end
  end
end
