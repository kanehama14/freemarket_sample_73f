Rails.application.routes.draw do
  # devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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

    resources :items, only: [:new, :index, :show] do
    end
  end
  
  resources :categories, only: :index do
    collection do
      get 'category1'
      get 'category2'
      get 'category3'
    end
  end

  resources :items do
    resources :purchases, only: [:index] do
      collection do
        get 'done', to: 'purchases#done'
      end
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      # get 'get_size', defaults: { format: 'json' }
    end
  end 
  

end
