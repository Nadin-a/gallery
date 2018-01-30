# frozen_string_literal: true

require 'spec_helper'
require 'capybara_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe 'action_cable_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:room) { FactoryBot.create(:random_room, user: user) }
  let!(:category) { FactoryBot.create(:fake_category, owner: user) }
  let!(:image) { FactoryBot.create(:random_image, category: category) }

  before do
    login(user)
  end

  describe 'Create message' do
    before { visit room_path(room) }

    it 'Send message', js: true do
      Sidekiq::Testing.inline! do
        fill_in 'New message...', with: 'Hello!'
        click_button 'Post'
        expect(page).to have_content('Hello!')
      end
    end
    it 'Show author of message', js: true do
      Sidekiq::Testing.inline! do
        fill_in 'New message...', with: 'Hello!'
        click_button 'Post'
        expect(page).to have_content(user.name)
      end
    end
  end

  describe 'Create comment' do
    before { visit category_image_path(category, image) }

    it 'Send comment', js: true do
      Sidekiq::Testing.inline! do
        fill_in 'New comment...', with: 'Hello!'
        click_button 'Post'
        expect(page).to have_content('Hello!')
      end
    end
    it 'Show author of comment', js: true do
      Sidekiq::Testing.inline! do
        fill_in 'New comment...', with: 'Hello!'
        click_button 'Post'
        expect(page).to have_content(user.name)
      end
    end
  end

  describe 'Create like' do
    before { visit category_image_path(category, image) }

    it 'Send like', js: true do
      Sidekiq::Testing.inline! do
        find('#like').click
        expect(page).to have_content('1')
      end
    end
    it 'Send dislike', js: true do
      Sidekiq::Testing.inline! do
        find('#like').click
        find('#like').click
        expect(page).to have_content('0')
      end
    end
  end
end
