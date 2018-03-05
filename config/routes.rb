Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events, except: [:edit, :update] do
    resources :gifts
  end

  resources :participations, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
end
