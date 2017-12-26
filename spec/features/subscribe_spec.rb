# frozen_string_literal: true

require 'spec_helper'
describe 'Subscribtion', type: :feature do
  before(:all) do
    @user = FactoryBot.create(:random_user)
    @category = FactoryBot.create(:random_category)
  end

  before do
    login(@user)
    visit category_path(@category)
  end

  describe 'Subscribe and unsubscribe' do
    it 'subscribe category', js: true do
      find('#subscribe').click
      expect(page).to have_content('Followers: 1')
    end

    it 'unsubscribe category', js: true do
      find('#subscribe').click
      expect(page).to have_content('Followers: 0')
    end
  end
end
