# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:room) { FactoryBot.create(:random_room) }
  let!(:message) { FactoryBot.create(:message, room: room, user: user) }
  let!(:invalid_message) { FactoryBot.build(:invalid_message, room: room, user: user) }

  before { sign_in(user) }

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new message' do
        message = FactoryBot.build(:random_message)
        expected = expect do
          post :create, params: { room_id: room, message: message.attributes }
        end
        expected.to change(Message, :count).by(1)
      end

      it 'redirect with correct status' do
        message = FactoryBot.build(:random_message)
        post :create, params: { room_id: room, message: message.attributes }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid attributes' do
      it 'does not save with invalid attributes' do
        expected = expect do
          post :create, params: { room_id: room, message: invalid_message.attributes }
        end
        expected.not_to change(Message, :count)
      end

      it 'show error message' do
        post :create, params: { room_id: room, message: invalid_message.attributes }
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
