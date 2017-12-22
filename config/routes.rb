Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'
  get '/popular_images', to: 'pages#popular_images'
  get '/last_comments', to: 'pages#last_comments'

  resources :users, only: %i[show destroy]
  resources :categories do
    collection do
      get :owned
      get :favorite
    end

    member do
      post :subscribe
      delete :unsubscribe
    end

    resources :images do
      resources :comments, only: %i[create]
      resources :likes, only: %i[create destroy]
    end
  end

  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

end
