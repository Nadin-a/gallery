# frozen_string_literal: true

require 'spec_helper'
describe 'image_features', type: :feature do
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
      expect(page).to have_content('0')
    end
  end
end
