Rails.application.routes.draw do
  # devise_for :users
  root 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items do
    resources :purchases, only: [:index] do
      collection do
        get 'done', to: 'purchases#done'
      end
    end
  end 
  
  resources :users, only: [:new, :index, :edit, :update] do
    resources :items, only: [:new, :index, :show] do

    end
  end
  
end
