Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :users, only: [:new, :index] do
    collection do
      get 'logout'
      get 'credit_regist'
    end
  end
  resources :items do
    member do
      get "buy"
      get "pay"
    end
  end
  resources :cards, only: [:new, :create, :show, :destroy] do
  end 
end
