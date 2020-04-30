Rails.application.routes.draw do
  root 'users#new1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users", to: "users#new1"
  resources :users do
    collection do
      get 'new1'
      post 'new2'
      # post 'step3'  #入力が全て完了
      # get 'complete_signup'  #登録完了後
    end
  end
end
