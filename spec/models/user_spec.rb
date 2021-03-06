# frozen_string_literal: true

require 'rails_helper'

describe User do
  subject(:user) { FactoryBot.build(:user) }

  let!(:no_activated_user) { FactoryBot.create(:random_user, confirmed_at: nil) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it 'is invalid without a name' do
    user.name = nil
    expect(user).not_to be_valid
  end
  it 'is invalid with short name' do
    user.name = 'a'
    expect(user).not_to be_valid
  end
  it 'is invalid with long name' do
    user.name = 'a' * 31
    expect(user).not_to be_valid
  end
  it 'is invalid without an e-mail' do
    user.email = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without a correct e-mail' do
    user.email = 'uncorrect email'
    expect(user).not_to be_valid
  end
  it 'is invalid without a password' do
    user.password = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without a correct password' do
    user.password = 'a' * 3
    expect(user).not_to be_valid
  end
  it 'is invalid without a matching password confirmation' do
    user.password = 'password'
    user.password_confirmation = 'foobar'
    expect(user).not_to be_valid
  end
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end
  it '.feed' do
    check_feed = user.feed == user.categories + user.owned_categories
    expect(check_feed).to be true
  end

  it 'active' do
    expect(described_class.active.include?(no_activated_user)).to be false
  end

  it 'can read all' do
    new_user = FactoryBot.create(:user)
    create_list(:notification, 25, recipient_id: new_user.id)
    new_user.read_all
    new_user.notifications.each do |notification|
      expect(notification.readed).to be true
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:owned_categories).with_foreign_key(:owner_id) }
    it { is_expected.to have_and_belong_to_many :categories }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :commented_images }
    it { is_expected.to have_many :likes }
    it { is_expected.to have_many :liked_images }
    it { is_expected.to have_many :owned_rooms }
    it { is_expected.to have_many :messages }
    it { is_expected.to have_many :ahoy_events }
    it { is_expected.to have_many :notifications }
    it { is_expected.to have_db_index('confirmation_token') }
    it { is_expected.to have_db_index('email') }
    it { is_expected.to have_db_index('reset_password_token') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_length_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
