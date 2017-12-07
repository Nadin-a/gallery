Rails.application.routes.draw do
  devise_for :users
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
      resources :comments, only: %i[create destroy]
      resources :likes, only: %i[create destroy]
    end
  end

end
