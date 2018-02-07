# frozen_string_literal: true

require 'spec_helper'
describe 'Subscribtion', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:random_category) }

  before do
    login(user)
    visit category_path(category)
  end

  describe 'Subscribtion and unsubscribtion' do
    it 'subscribe to category', js: true do
      find('#js-subscribe').click
      expect(page).to have_content('Followers: 1')
    end

    it 'visit followers page', js: true do
      find('#js-subscribe').click
      visit followers_category_path(category)
      expect(page).to have_content(user.name)
    end

    it 'unsubcribe to category', js: true do
      visit category_path(category)
      find('#js-subscribe').click
      find('#js-subscribe').click
      expect(page).to have_content('Followers: 0')
    end
  end
end
