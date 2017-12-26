# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  subject(:comment) { FactoryBot.build(:comment) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:comment)).to be_valid
  end
  it 'is not valid without a content' do
    comment.content = nil
    expect(comment).not_to be_valid
  end
  it 'is not valid with long content' do
    comment.content = 'a' * 301
    expect(comment).not_to be_valid
  end
  it 'is not valid without a user' do
    comment.user = nil
    expect(comment).not_to be_valid
  end
  it 'is not valid without a user' do
    comment.image = nil
    expect(comment).not_to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :image }
    it { is_expected.to have_db_index('image_id') }
    it { is_expected.to have_db_index('user_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :image }
    it { is_expected.to validate_length_of :content }
  end
end