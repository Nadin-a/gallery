# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ImageChannel, type: :channel do
  let!(:user) { FactoryBot.create(:random_user) }

  before do
    stub_connection user_id: user.id
  end

  it 'subscribes to a stream image room id is provided' do
    subscribe(image_id: 1)
    expect(subscription).to be_confirmed
  end
end
