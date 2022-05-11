Rails.application.routes.draw do

  resources :users
  put 'users/member/:id', to: 'users#toggle_member'
  
  resources :posts, only: [:index]
  get 'posts/user/:id', to: 'posts#get_user_posts'
end
