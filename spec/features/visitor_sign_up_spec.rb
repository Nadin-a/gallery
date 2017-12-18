require 'spec_helper'

feature 'Visitor signs up' do

  let!(:user) { FactoryBot.create(:random_user) }

  scenario 'with valid parameters', js: true do
    sign_up_with user.email, user.name,user.password, user.password_confirmation

    expect(page).to have_content('Log in')
  end

  scenario 'with invalid email', js: true do
    sign_up_with '', user.name,user.password, user.password_confirmation

    expect(page).to have_content('Log in')
  end

  scenario 'with invalid name', js: true do
    sign_up_with user.email, '',user.password, user.password_confirmation

    expect(page).to have_content('Log in')
  end

  scenario 'with different passwords', js: true do
    sign_up_with user.email, user.name,user.password, ''

    expect(page).to have_content('Log in')
  end

  def sign_up_with(email, name, password, password_confirmation)
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'Name', with: name
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
    click_button 'Sign up'
  end
end
