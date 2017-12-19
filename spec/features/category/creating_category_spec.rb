require 'spec_helper'

feature 'Creating category' do
  let!(:user) { FactoryBot.create(:random_user) }
  before { login(user) }
  category_name = Faker::Lorem.word

  scenario 'can create a category', js: true do
    visit categories_path
    click_button 'Create own category'
    fill_in 'Name', with: category_name
    click_button 'Create'
    expect(page).to have_content(user.name)
    expect(page).to have_content(category_name)
    expect(page).to have_content('Add image | Update | Delete')
    visit owned_categories_path
    expect(page).to have_content(category_name)
  end

  scenario 'can not create a category with same name', js: true do
    visit categories_path
    click_button 'Create own category'
    fill_in 'Name', with: category_name
    click_button 'Create'
    expect(page).to have_content('All categories')
    expect(page).to have_content('Name has already been taken')
  end

  scenario 'can not create category with invalid params', js: true do
    visit categories_path
    click_button 'Create own category'
    fill_in 'Name', with: ''
    click_button 'Create'
    expect(page).to have_content('All categories')
    expect(page).to have_content("Name can't be blank")
  end
end
