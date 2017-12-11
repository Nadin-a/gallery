# frozen_string_literal: true

require 'rails_helper'

describe User do
  subject {
    described_class.new(name: 'User', email: 'email@mail.com',
                        password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
  }
  it 'has a valid factory' do
    FactoryBot.build(:user).should be_valid
  end
  it 'is invalid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'is invalid with long name' do
    subject.name = 'a' * 21
    expect(subject).to_not be_valid
  end
  it 'is invalid without an e-mail' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it 'is invalid without a correct e-mail' do
    subject.email = 'uncorrect email'
    expect(subject).to_not be_valid
  end
  it 'is invalid without a password'  do
    subject.password = nil
    expect(subject).to_not be_valid
  end
  it 'is invalid without a correct password' do
    subject.password = 'a' * 3
    expect(subject).to_not be_valid
  end
  it 'is invalid without a matching password confirmation' do
    subject.password = 'password'
    subject.password_confirmation = 'foobar'
    expect(subject).to_not be_valid
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to  have_many(:owned_categories) }
    it { is_expected.to  have_and_belong_to_many(:categories) }
    it { is_expected.to  have_many(:comments) }
    it { is_expected.to  have_many(:commented_images) }
    it { is_expected.to  have_many(:likes) }
    it { is_expected.to  have_many(:liked_images) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
