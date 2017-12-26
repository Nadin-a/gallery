require 'spec_helper'

describe 'Find' do
  before(:all) {
    @user = FactoryBot.create(:random_user)
  }

  describe 'on main page' do
    scenario 'content_instead_carousel', js: true do
      visit root_path
      expect(page).to have_content('No images on site')
      login @user
      expect(page).to have_content('You have not any images.
      Subscribe on any category or add own image and you will see it here!')
    end
  end

end
