# frozen_string_literal: true

require 'rails_helper'

describe Category do
  subject(:category) {
    FactoryBot.build(:category)
  }

  it 'has a valid factory' do
    expect(FactoryBot.build(:category)).to be_valid
  end
  it 'is not valid without a name' do
    category.name = nil
    expect(category).to_not be_valid
  end
  it 'is not valid with long name' do
    category.name = 'a' * 31
    expect(category).to_not be_valid
  end
  it 'is not valid without a owner' do
    category.owner = nil
    expect(category).to_not be_valid
  end
  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end
  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end
  it 'can check own subscribers' do
    user = FactoryBot.build(:user)
    user.categories << category
    check = category.has_subscriber? user
    expect(check).to be true
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:owner).with_foreign_key(:owner_id) }
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to have_many(:images) }
    it { is_expected.to have_db_index('name') }
    it { is_expected.to have_db_index('owner_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_length_of(:name) }
  end
end
