# frozen_string_literal: true

require 'spec_helper'

describe 'room_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:room) { FactoryBot.create(:random_room, user: user) }

  before { login(user) }

  describe 'Creating room' do
    name = 'room1'

    it 'with valid parameters', js: true do
      visit rooms_path
      click_button 'Create new room'
      fill_in 'Name', with: name
      click_button 'Create'
      expect(page).to have_content(name)
    end

    it 'with successful message', js: true do
      visit rooms_path
      click_button 'Create new room'
      fill_in 'Name', with: name
      click_button 'Create'
      expect(page).to have_content('Room created!')
    end

    it 'with long name', js: true do
      visit rooms_path
      click_button 'Create new room'
      fill_in 'Name', with: 'a' * 21
      click_button 'Create'
      expect(page).to have_content('Name is too long (maximum is 20 characters) ')
    end

    it 'message', js: true do
      visit room_path(room)
      fill_in 'New message...', with: 'message'
      find('#btn-message-post').click
      expect(page).to have_content('message')
    end
  end

  describe 'Visit and updating room' do
    before { visit room_path(room) }

    new_room_name = Faker::Lorem.word

    it 'with valid new parameters', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_room_name
      click_button 'Update'
      expect(page).to have_content(new_room_name)
    end

    it 'with successful message', js: true do
      click_link 'Update'
      fill_in 'Name', with: new_room_name
      click_button 'Update'
      expect(page).to have_content('Room updated!')
    end

    it 'with long name', js: true do
      click_link 'Update'
      fill_in 'Name', with: 'a' * 21
      click_button 'Update'
      expect(page).to have_content('Name is too long (maximum is 20 characters')
    end
  end

  describe 'Deleting room' do
    before { visit room_path(room) }
    it 'with click on delete', js: true do
      click_link 'Delete'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content('Room deleted!')
    end
  end
end
