# frozen_string_literal: true

require 'rails_helper'

describe Image do
  let(:owner) { User.new(name: 'User', email: 'email@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)}
  let(:category){Category.new(name: 'cars', owner: owner)}
  subject {
    described_class.new(title: 'picture', description: 'some description',
                        category: category, picture: Rails.root.join("app/assets/images/test_picture.jpg").open)
  }
  it 'has a valid factory' do
    #FactoryBot.build(:image).should be_valid
  end
  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid with long title' do
    subject.title = 'a' * 31
    expect(subject).to_not be_valid
  end
  it 'is not valid without a picture' do
    subject.picture = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid with long description' do
    subject.title = 'a' * 141
    expect(subject).to_not be_valid
  end
  it 'is valid with without description' do
    subject.description = nil
    expect(subject).to be_valid
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liking_users) }
    it { is_expected.to have_db_index('category_id') }
    it { is_expected.to have_db_index('title') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:picture) }
    it { is_expected.to validate_length_of(:title) }
    it { is_expected.to validate_length_of(:description) }
    it { is_expected.to validate_uniqueness_of (:title) }
  end
end