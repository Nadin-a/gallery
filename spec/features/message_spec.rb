# frozen_string_literal: true

require 'spec_helper'
describe 'image_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:room) { FactoryBot.create(:room, user: user) }

  before do
    login(user)
    visit room_path(room)
  end

  message = Faker::Lorem.sentence

  describe 'Creating message' do
    it 'with valid parameters', js: true do
      fill_in 'New message...', with: message
      click_button 'Post'
      expect(page).to have_content(message)
    end
    it 'with empty content', js: true do
      fill_in 'New message...', with: ''
      click_button 'Post'
      expect(page).to have_content("Content can't be blank")
    end
    it 'with long content', js: true do
      fill_in 'New message...', with: 'a' * 1001
      click_button 'Post'
      expect(page).to have_content('Content is too long (maximum is 1000 characters)')
    end
  end
end