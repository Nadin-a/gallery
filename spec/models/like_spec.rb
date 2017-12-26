# frozen_string_literal: true

require 'rails_helper'

describe Like do
  subject(:like) { FactoryBot.build(:like) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:like)).to be_valid
  end
  it 'is not valid without a user' do
    like.user = nil
    expect(like).not_to be_valid
  end
  it 'is not valid without a user' do
    like.image = nil
    expect(like).not_to be_valid
  end
  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :image }
    it { is_expected.to have_db_index('image_id') }
    it { is_expected.to have_db_index('user_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :image }
  end
end
