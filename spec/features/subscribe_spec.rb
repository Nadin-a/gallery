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
      find('#subscribe').click
      expect(page).to have_content('Followers: 1')
    end
    it 'unsubcribe to category', js: true do
      find('#subscribe').click
      find('#subscribe').click
      expect(page).to have_content('Followers: 0')
    end
  end
end
