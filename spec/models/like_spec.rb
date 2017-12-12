# frozen_string_literal: true

require 'rails_helper'

describe Like do
  subject { FactoryBot.build(:like) }
  it 'has a valid factory' do
    FactoryBot.build(:like).should be_valid
  end
  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a user' do
    subject.image = nil
    expect(subject).to_not be_valid
  end
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:image) }
    it { is_expected.to have_db_index('image_id') }
    it { is_expected.to have_db_index('user_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:image) }
  end
end