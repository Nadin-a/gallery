# frozen_string_literal: true

require 'spec_helper'
describe 'Visitor signs up', type: :feature do
  let!(:email) { Faker::Internet.safe_email }
  let!(:name) { Faker::Name.first_name }

  it 'with valid parameters', js: true do
    visit root_path
    click_link 'Sign up'
    expect(page).to have_current_path('/users/sign_up')
    sign_up_with email, name, 'password', 'password'
  end

  it 'with empty email' do
    sign_up_with '', 'name', 'password', 'password'
    expect(page).to have_content("Email can't be blank")
  end

  it 'with invalid name' do
    sign_up_with email, '', 'password', 'password'
    expect(page).to have_content("Name can't be blank")
  end

  it 'with short name' do
    sign_up_with email, 'a', 'password', 'password'

    expect(page).to have_content('Name is too short (minimum is 2 characters)')
  end

  it 'with long name' do
    sign_up_with email, 'a' * 21, 'password', 'password'
    expect(page).to have_content('Name is too long (maximum is 20 characters)')
  end

  it 'with empty password' do
    sign_up_with email, name, '', ''
    expect(page).to have_content("Password can't be blank")
  end

  it 'with invalid password' do
    sign_up_with email, name, 'a' * 3, 'a' * 3
    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end

  it 'with uncorrect confirmation' do
    sign_up_with email, name, 'password', ''
    expect(page).to have_content("Password confirmation doesn't match Password")
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
