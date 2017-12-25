# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AdminUser, type: :model do
  subject(:admin) {
    FactoryBot.build(:admin_user)
  }

  it 'has a valid factory' do
    expect(FactoryBot.build(:admin_user)).to be_valid
  end
  it 'is invalid without an e-mail' do
    admin.email = nil
    expect(admin).not_to be_valid
  end
  it 'is invalid without a correct e-mail' do
    admin.email = 'uncorrect email'
    expect(admin).not_to be_valid
  end
  it 'is invalid without a password' do
    admin.password = nil
    expect(admin).not_to be_valid
  end
  it 'is invalid without a correct password' do
    admin.password = 'a' * 3
    expect(admin).not_to be_valid
  end
  describe 'Associations' do
    it { is_expected.to have_db_index('confirmation_token') }
    it { is_expected.to have_db_index('email') }
    it { is_expected.to have_db_index('reset_password_token') }
  end
end
