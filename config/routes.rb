Rails.application.routes.draw do
  # devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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
  resources :users, only: [:new, :index, :edit, :update] do
    collection do
      get 'logout'
      get 'credit_regist'
      get 'new1'
      get 'new2'
      get 'new3'
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
end
