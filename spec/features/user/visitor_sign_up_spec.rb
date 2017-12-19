# frozen_string_literal: true

require 'spec_helper'
feature 'Visitor signs up' do
  let!(:user) { FactoryBot.create(:random_user) }

  scenario 'with valid parameters' do
    visit root_path

    click_link 'Sign up'
    expect(current_path).to eq(new_user_registration_path)

    sign_up_with Faker::Internet.safe_email, Faker::Name.first_name ,'password', 'password'
  end


  scenario 'with empty email' do
    sign_up_with '', user.name,user.password, user.password_confirmation

    expect(page).to have_content("Email can't be blank")
  end


  scenario 'with invalid name' do
    sign_up_with user.email, '',user.password, user.password_confirmation

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'with short name' do
    sign_up_with user.email, 'a',user.password, user.password_confirmation

    expect(page).to have_content('Name is too short (minimum is 2 characters)')
  end

  scenario 'with long name' do
    sign_up_with user.email, 'a'*21,user.password, user.password_confirmation

    expect(page).to have_content('Name is too long (maximum is 20 characters)')
  end

  scenario 'with empty password' do
    sign_up_with user.email, user.name,'', ''

    expect(page).to have_content("Password can't be blank")
  end

  scenario 'with invalid password' do
    sign_up_with user.email, user.name,'a'*3, 'a'*3

    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end


  scenario 'with different passwords' do
    sign_up_with user.email, user.name,user.password, ''

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

  private

  def expect_fields_to_be_blank
    expect(page).to have_field("Email", with: "", type: "email")
    expect(page).to have_field("Name", with: "", type: "text")
    expect(find_field("Password", type: "password").value).to be_nil
    expect(find_field("Password confirmation", type: "password").value).to be_nil
  end
end
