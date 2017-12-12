require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject {
    FactoryBot.build(:admin_user)
  }
  it 'has a valid factory' do
    FactoryBot.build(:admin_user).should be_valid
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
  describe 'Associations' do
    it { is_expected.to  have_db_index('confirmation_token') }
    it { is_expected.to  have_db_index('email') }
    it { is_expected.to  have_db_index('reset_password_token') }
  end
end
