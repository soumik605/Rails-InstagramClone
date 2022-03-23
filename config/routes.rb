Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts do
    resources :comments, only: [:edit, :create, :update, :destroy]
    resources :likes, only: [:index, :create]
  end

  devise_for :users


  post '/users/:id/follow', to: 'follows#create', as: 'follow'
  delete '/users/:id/unfollow', to: 'follows#destroy', as: 'unfollow'

  get '/user/:user_id/account', to: 'public#account', as: 'account'
  get '/user/:user_id/friends', to: 'public#friend', as: 'friend'

  get '/suggestions', to: 'public#suggestion', as: 'suggestion'

end
