# frozen_string_literal: true

require 'spec_helper'
describe 'Subscribtion' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category)

  }

  before {
    login(@user)
    visit category_path(@category)
  }

  describe 'Subscribe and unsubscribe' do
    scenario 'opened image', js: true do
      find('#subscribe').click
      expect(page).to have_content('Followers: 1')
      visit favorite_categories_path
      expect(page).to have_content(@category.name)
      visit category_path(@category)
      find('#subscribe').click
      expect(page).to have_content('Followers: 0')
    end
  end
end
