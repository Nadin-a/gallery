# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #pages' do
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
  end
end
