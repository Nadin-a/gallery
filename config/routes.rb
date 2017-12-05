Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

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

    resources :images
  end
end
