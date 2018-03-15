Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations", sessions: 'sessions' }
  resources :users, only: [:edit, :update]
  resources :events, except: [:show] do
    resources :invites, only: [:new, :create] do
      collection do
        get 'resend', to: "invites#resend"
      end
    end
    resources :gifts
    resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index, :create]
    end
  end
  resources :participations, only: [:show, :create, :update] do
    resources :payments, only: [:new, :create]
  end

end
