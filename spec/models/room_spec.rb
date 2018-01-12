# frozen_string_literal: true

require 'rails_helper'

describe Room do
  subject(:room) { FactoryBot.build(:room) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:room)).to be_valid
  end
  it 'is not valid without a name' do
    room.name = nil
    expect(room).not_to be_valid
  end
  it 'is not valid with long name' do
    room.name = 'a' * 21
    expect(room).not_to be_valid
  end
  it 'is not valid without a user' do
    room.user = nil
    expect(room).not_to be_valid
  end
  it 'is valid with valid attributes' do
    expect(room).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user).with_foreign_key(:user_id) }
    it { is_expected.to have_many :messages }
    it { is_expected.to have_db_index('name') }
    it { is_expected.to have_db_index('user_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_length_of :name }
  end
end
