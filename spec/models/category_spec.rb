# frozen_string_literal: true

require 'rails_helper'

describe Category do
  let(:user) { FactoryBot.create(:user) }
  it 'has a valid factory' do
    FactoryBot.build(:category).should be_valid
  end
end
