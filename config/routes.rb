Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:edit, :update]
  resources :events, except: [:show, :edit, :update] do
    resources :gifts
  end
  resources :participations, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
end
