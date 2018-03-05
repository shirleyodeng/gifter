Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:edit, :update]

  resources :events, except: [:show, :edit, :update] do
    resources :gifts
  end

  resources :participations, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
end
