# frozen_string_literal: true

require 'spec_helper'
describe 'user_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }

  before do
    login(user)
    visit edit_user_registration_path(@user)
  end

  describe 'Visit own profile' do
    context 'when update information with valid parameters' do
      it 'redirect to home page', js: true do
        fill_in 'Name', with: 'Nadiia Trofymova'
        fill_in 'Password', with: ''
        fill_in 'Current password', with: 'password'
        click_button 'Update'
        expect(page).to have_current_path root_path
      end
      it 'show correct name in public profile', js: true do
        fill_in 'Name', with: 'Nadiia Trofymova'
        fill_in 'Password', with: ''
        fill_in 'Current password', with: 'password'
        click_button 'Update'
        visit user_path(user)
        expect(page).to have_content('Nadiia Trofymova')
      end
    end
    context 'when see public profile' do
      it 'watch information', js: true do
        visit user_path(user)
        expect(page).to have_content('Comments: ' + user.comments.count.to_s +
                                     ' Favorite categories: ' + user.categories.count.to_s)
      end
    end
  end
end
