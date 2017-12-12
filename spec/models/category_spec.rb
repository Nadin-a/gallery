# frozen_string_literal: true

require 'rails_helper'

describe Category do
  let(:owner) {FactoryBot.build(:user)}
  subject {
    FactoryBot.build(:category)
  }
  it 'has a valid factory' do
    FactoryBot.build(:category).should be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid with long name' do
    subject.name = 'a' * 31
    expect(subject).to_not be_valid
  end
  it 'is not valid without a owner' do
    subject.owner = nil
    expect(subject).to_not be_valid
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
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
