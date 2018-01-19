# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ChatRoomsChannel, type: :channel do
  let!(:user) { FactoryBot.create(:random_user) }
  let(:room) { FactoryBot.create(:random_room, user: user) }

  before do
    stub_connection user_id: user.id
  end

  it 'subscribes to a stream when room id is provided' do
    subscribe(room_id: 1)
    expect(subscription).to be_confirmed

  end
end
