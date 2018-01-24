# frozen_string_literal: true

require 'spec_helper'
describe 'Visitor signs up', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }

  it 'with valid email and password have info message', js: true do
    log_in_with user.email, user.password
    expect(page).to have_content 'You have not any images. Subscribe on any category
    or add own image and you will see it here!'
  end

  it 'with valid email and password have success message', js: true do
    log_in_with user.email, user.password
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'with invalid email', js: true do
    log_in_with 'invalid_email', user.password
    expect(page).to have_content('Login')
  end

  it 'with blank password', js: true do
    log_in_with user.email, ''
    expect(page).to have_content('Login')
  end

  it 'and can sign out after login', js: true do
    log_in_with user.email, user.password
    click_link 'Sign out'
    expect(page).to have_current_path(root_path)
  end

  def log_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Login'
  end
end
