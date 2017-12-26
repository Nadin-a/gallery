# frozen_string_literal: true

require 'spec_helper'
describe 'Find', type: :feature do
  before(:all) { @user = FactoryBot.create(:random_user) }

  describe 'on main page' do
    it 'content_instead_carousel', js: true do
      visit root_path
      expect(page).to have_content('No images on site')
    end

    it 'content_instead_carousel_user_login', js: true do
      login @user
      expect(page).to have_content('You have not any images.
      Subscribe on any category or add own image and you will see it here!')
    end
  end
end
