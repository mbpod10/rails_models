Rails.application.routes.draw do

  # resources :users
  # put 'users/member/:id', to: 'users#toggle_member'
  
  resources :posts, only: [:index, :show]
  # get 'posts/user/:id', to: 'posts#get_user_posts'

  # resources :comments
  
  # resources :posts do
  #   resources :comments
  #  end
  #  http://127.0.0.1:3000/posts.json?comments=true&user=true
end
