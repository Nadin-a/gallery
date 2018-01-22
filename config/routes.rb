Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, lambda { |user| user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    ActiveAdmin.routes(self)
  end

  devise_for :users, controllers:{ omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'
  get '/popular_images', to: 'pages#popular_images'
  get '/last_comments', to: 'pages#last_comments'
  get '/updates', to: 'pages#updates'

  resources :users, only: %i[index show destroy]

  resources :categories do
    collection do
      get :owned
      get :favorite
      get :popular
    end

    member do
      post :subscribe
      delete :unsubscribe
      get :followers
    end

    resources :images do
      resources :comments, only: %i[destroy]
      resources :likes, only: %i[create destroy]
    end
  end

  resources :rooms
end
