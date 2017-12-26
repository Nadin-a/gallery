# frozen_string_literal: true

module UserHelper
  def login(user)
    visit root_path
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  def logout
    visit root_path
    click_link 'Sign Out'
  end
end
