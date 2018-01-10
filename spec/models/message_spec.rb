# frozen_string_literal: true

require 'rails_helper'

describe Message do
  subject(:message) { FactoryBot.build(:message) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:message)).to be_valid
  end
  it 'is not valid without a content' do
    message.content = nil
    expect(message).not_to be_valid
  end
  it 'is not valid with long content' do
    message.content = 'a' * 1001
    expect(message).not_to be_valid
  end
  it 'is not valid without a user' do
    message.user = nil
    expect(message).not_to be_valid
  end
  it 'is not valid without a room' do
    message.room = nil
    expect(message).not_to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :room }
    it { is_expected.to have_db_index('room_id') }
    it { is_expected.to have_db_index('user_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :room }
    it { is_expected.to validate_length_of :content }
  end
end
