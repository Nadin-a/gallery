require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  subject {
    described_class.new(email: 'email@mail.com',
                        password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
  }
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
end
