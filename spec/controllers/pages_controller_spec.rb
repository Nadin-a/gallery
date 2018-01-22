# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'render templates' do
    it 'renders the :home view' do
      get :home
      expect(response).to render_template('home')
    end

    it 'renders the :popular_images view' do
      get :popular_images
      expect(response).to render_template('popular_images')
    end

    it 'renders the :last_comments view' do
      get :last_comments
      expect(response).to render_template('last_comments')
    end

    it 'renders the :updates view' do
      get :updates
      expect(response).to render_template('updates')
    end
  end

  describe 'responses' do
    it 'get home' do
      get :home
      expect(response).to have_http_status(200)
    end

    it 'get popular images' do
      get :popular_images
      expect(response).to have_http_status(200)
    end

    it 'get last comments' do
      get :last_comments
      expect(response).to have_http_status(200)
    end

    it 'get updates' do
      get :updates
      expect(response).to have_http_status(200)
    end
  end
end
