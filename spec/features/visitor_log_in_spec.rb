require 'spec_helper'

feature 'Visitor signs up' do

  let!(:user) { FactoryBot.create(:random_user) }

  scenario 'with valid email and password', js: true do
    log_in_with user.email, user.password

    expect(page).to have_content('Sign out')
  end

  scenario 'with valid email and password get my categories', js: true  do
    log_in_with user.email, user.password

    expect(page).to have_content('My categories')
  end

  scenario 'with valid email and password get favorite categories', js: true  do
    log_in_with user.email, user.password

    expect(page).to have_content('Favorite categories')
  end

  scenario 'with invalid email', js: true  do
    log_in_with 'invalid_email', user.password

    expect(page).to have_content('Log in')
  end

  scenario 'with blank password', js: true  do
    log_in_with user.email, ''

    expect(page).to have_content('Log in')
  end

  def log_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
