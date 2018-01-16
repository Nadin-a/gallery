# frozen_string_literal: true

require 'spec_helper'
describe 'comment_features', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:random_category, owner: user) }
  let!(:image) { FactoryBot.create(:random_image, category: category) }
  let!(:comments) do
    10.times do
      FactoryBot.create(:comment, image: image, user: user)
    end
  end

  before do
    login(user)
    visit category_image_path(category, image)
  end

  describe 'Showing hidden comments' do
    it 'has label', js: true do
      expect(page).to have_content('Show all comments')
    end
    it 'show last 5 comments', js: true do
      expect(page).to have_content('some content', count: 5)
    end
    it 'remove label after click', js: true do
      find('#show_all_comments_link').click
      expect(page).not_to have_content('Show all comments')
    end
    it 'show hidden comments', js: true do
      find('#show_all_comments_link').click
      expect(page).to have_content('some content', count: 10)
    end
  end
end
