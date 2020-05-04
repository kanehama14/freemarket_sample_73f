Rails.application.routes.draw do
  # devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'registrations/info', to: 'users/registrations#new_info'
    post 'registrations/info', to: 'users/registrations#create_info'
    get 'registrations/addresses', to: 'users/registrations#new_address'
    post 'registrations/addresses', to: 'users/registrations#create_address'
  end
  
  resources :users, only: [:new, :index, :edit, :update] do
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
