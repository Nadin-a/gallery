# frozen_string_literal: true

require 'rails_helper'

describe Like do
  let(:user) { User.new(name: 'User', email: 'email@mail.com', password: 'password', password_confirmation: 'password',  confirmed_at: Time.now) }
  let(:category){Category.new(name: 'cars', owner: user)}
  let(:image){ Image.new(title: 'picture', description: 'some description', category: category, picture: Rails.root.join("app/assets/images/test_picture.jpg").open) }
  subject { described_class.new(user: user, image: image) }
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