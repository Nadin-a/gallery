# frozen_string_literal: true

require 'rails_helper'

describe Image do
  subject(:image) {
    FactoryBot.build(:image)
  }
  it 'has a valid factory' do
    expect(FactoryBot.build(:image)).to be_valid
  end
  it 'is not valid without a title' do
    image.title = nil
    expect(image).to_not be_valid
  end
  it 'is not valid with long title' do
    image.title = 'a' * 31
    expect(image).to_not be_valid
  end
  it 'is not valid without a picture' do
    image.picture = nil
    expect(image).to_not be_valid
  end
  it 'is not valid with long description' do
    image.title = 'a' * 141
    expect(image).to_not be_valid
  end
  it 'is valid with without description' do
    image.description = nil
    expect(image).to be_valid
  end
  it 'is valid with valid attributes' do
    expect(image).to be_valid
  end
  it 'can check who like' do
    user = FactoryBot.build(:user)
    user.liked_images << image
    check = subject.liked_by? user
    expect(check).to be true
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liking_users) }
    it { is_expected.to have_db_index('category_id') }
    it { is_expected.to have_db_index('title') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:picture) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to validate_length_of(:description) }
    it { is_expected.to validate_uniqueness_of (:title) }
  end
end