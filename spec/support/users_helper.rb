# frozen_string_literal: true

module UserHelper
  def login(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  def logout
    visit root_path
    click_link 'Sign Out'
  end
end
