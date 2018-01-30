# frozen_string_literal: true

require 'spec_helper'
describe CategoriesHelper, type: :helper do
  let!(:category) { FactoryBot.create(:fake_category, cover: nil) }
  let!(:second_category) { FactoryBot.create(:fake_category) }

  describe '.set_cover' do
    it 'set default' do
      @category = category
      expect(helper.set_cover).to have_content('hd-wallpapers.jpg')
    end
    it 'set category cover' do
      @category = second_category
      expect(helper.set_cover).to have_content('test_picture.jpg')
    end
  end
end
