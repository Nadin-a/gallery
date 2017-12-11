# frozen_string_literal: true

require 'rails_helper'

describe Category do
  let(:owner) { User.new(name: 'User', email: 'email@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)}
  subject {
    described_class.new(name: 'cars', owner: owner)
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
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to have_and_belong_to_many(:users) }
    it { is_expected.to have_many(:images) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_length_of(:name) }
  end
end
