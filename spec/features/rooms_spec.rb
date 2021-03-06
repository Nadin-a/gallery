# frozen_string_literal: true

require 'spec_helper'

describe 'room_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:room) { FactoryBot.create(:random_room, user: user) }
  let!(:second_room) { FactoryBot.create(:random_room, user: user) }

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

    it 'with error message when room with same name exist', js: true do
      visit rooms_path
      click_button 'Create new room'
      fill_in 'Name', with: room.name
      click_button 'Create'
      expect(page).to have_content('Name has already been taken')
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

    it 'with error message when room with same name exist', js: true do
      click_link 'Update'
      fill_in 'Name', with: second_room.name
      click_button 'Update'
      expect(page).to have_content('Name has already been taken')
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
