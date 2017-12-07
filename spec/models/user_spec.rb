require 'rails_helper'

describe User do
  it 'has a valid factory' do
    FactoryBot.build(:user).should be_valid
  end
  it 'is invalid without an e-mail'
  it 'is invalid without a correct e-mail'
  it 'is invalid without a password'
  it 'is invalid without a matching password confrimation'
end
