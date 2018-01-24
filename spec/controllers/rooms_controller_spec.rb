# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:random_user) }
  let!(:room) { FactoryBot.create(:room, user: user) }
  let(:uncorrect_room) { FactoryBot.build(:uncorrect_room) }
  let!(:message) { FactoryBot.create(:message, room: room, user: user) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template('index')
    end

    it 'have response' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'show room' do
      get :show, params: { id: room.id }
      expect(assigns(:room)).to eq(room)
    end

    it 'render show' do
      get :show, params: { id: room.id }
      expect(response).to render_template :show
    end

    it 'have response' do
      get :show, params: { id: room.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new room' do
        room = FactoryBot.build(:random_room)
        expected = expect do
          post :create, params: { room: room.attributes }
        end
        expected.to change(Room, :count).by(1)
      end

      it 'redirect to a new room' do
        room = FactoryBot.build(:random_room)
        post :create, params: { room: room.attributes }
        expect(response).to redirect_to(Room.first)
      end

      it 'show succesful message' do
        room = FactoryBot.build(:random_room)
        post :create, params: { room: room.attributes }
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new room' do
        expected = expect do
          post :create, params: { room: uncorrect_room.attributes }
        end
        expected.not_to change(Room, :count)
      end

      it 'does not save the new room and show error message' do
        post :create, params: { room: uncorrect_room.attributes }
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'PUT update' do
    let(:room_params) { { id: room.id, room: { name: 'Room2' } } }
    let(:invalid_room_params) { { id: room.id, room: { name: '' } } }

    context 'with valid attributes' do
      it 'located the requested room' do
        expected = expect { put :update, params: room_params }
        expected.to change { room.reload.name }.from('Room1').to('Room2')
      end

      it 'redirects to the updated room' do
        put :update, params: room_params
        expect(response).to redirect_to(room.reload)
      end

      it 'show successful message' do
        put :update, params: room_params
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'can`t update room' do
        put :update, params: invalid_room_params
        expect(response).not_to be_success
      end

      it 'redirect to index' do
        put :update, params: invalid_room_params
        expect(response).to redirect_to(room)
      end

      it 'show error message' do
        put :update, params: invalid_room_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'delete the room' do
      expected = expect { delete :destroy, params: { id: room.id } }
      expected.to change(Room, :count).by(-1)
    end

    it 'redirects to roomw' do
      delete :destroy, params: { id: room.id }
      expect(response).to redirect_to rooms_path
    end

    it 'show successful message' do
      delete :destroy, params: { id: room.id }
      expect(flash[:success]).not_to be_nil
    end

    it 'delete with messages' do
      expected = expect { delete :destroy, params: { id: room.id } }
      expected.to change(Message, :count).by(-1)
    end
  end
end
