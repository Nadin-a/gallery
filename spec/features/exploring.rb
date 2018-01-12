# frozen_string_literal: true

require 'spec_helper'
describe 'Find', type: :feature do
  let!(:user) { FactoryBot.create(:random_user) }

  before { login(user) }

  describe 'on main page' do
    context 'without any content' do
      it 'content_instead_carousel', js: true do
        visit root_path
        click_link 'Sign out'
        expect(page).to have_content('No images on site')
      end

      it 'content_instead_carousel_user_login', js: true do
        expect(page).to have_content('You have not any images.
      Subscribe on any category or add own image and you will see it here!')
      end

      it 'visit popular images', js: true do
        visit popular_images_path
        expect(page).to have_content('Popular images There are no popular pictures on site!')
      end
      it 'visit last comments', js: true do
        visit last_comments_path
        expect(page).to have_content('Last comments There are no comments on site!')
      end
      it 'visit updates comments', js: true do
        visit updates_path
        expect(page).to have_content('Popular images There are no popular pictures on site!
        Last comments There are no comments on site!')
      end
    end
  end

  describe 'other pages', js: true do
    let!(:top_category) { FactoryBot.create(:category, owner: user) }
    let!(:image) { FactoryBot.create(:random_image, category: top_category) }
    let!(:comment) { FactoryBot.create(:random_comment, image: image) }
    let!(:second_category) { FactoryBot.create(:fake_category, owner: user) }

    context 'with content' do
      it 'content on my categories' do
        visit owned_categories_path
        expect(page).to have_content('My categories')
      end

      it 'content on favorite categories' do
        visit favorite_categories_path
        expect(page).to have_content('Favorite categories')
      end

      it 'content on all categories top 5' do
        visit popular_categories_path
        expect(page).to have_content('TOP 5 Cars Images: 1 Delete ' + second_category.name)
      end

      it 'content on all categories' do
        visit categories_path
        expect(page).to have_content('All categories')
      end

      it 'visit popular images', js: true do
        visit popular_images_path
        expect(page).to have_content('Popular images')
      end
      it 'visit last comments', js: true do
        visit last_comments_path
        expect(page).to have_content('Last comments')
      end
    end
  end
end
