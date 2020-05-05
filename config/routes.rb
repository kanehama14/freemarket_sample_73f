Rails.application.routes.draw do
  # devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :users, only: [:new, :index, :edit, :update] do
    collection do
      get 'logout'
      get 'credit_regist'
    end

    resources :items, only: [:new, :index, :show] do
    end
  end

  resources :items do
    resources :purchases, only: [:index] do
      collection do
        get 'done', to: 'purchases#done'
      end
    end
  end 
  

end
