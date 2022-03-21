Rails.application.routes.draw do

  resources :posts do
    resources :comments
  end

  devise_for :users

  root to: "posts#index"

  post '/posts/:id/like', to: 'posts#like', as: 'like'

  post '/posts/:id/comment', to: 'posts#addcomment', as: 'addcomment'
  delete '/posts/:id/comment', to: 'posts#deletecomment', as: 'deletecomment'

  post '/users/:id/follow', to: 'follows#create', as: 'follow'
  delete '/users/:id/unfollow', to: 'follows#destroy', as: 'unfollow'

  get '/user/account/:user_id', to: 'public#account', as: 'account'

end
