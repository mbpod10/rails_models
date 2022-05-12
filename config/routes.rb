Rails.application.routes.draw do

  resources :users
  # put 'users/member/:id', to: 'users#toggle_member'
  
 
  resources :posts
  # get 'posts/paginate/:limit', to:'posts#paginate'
  get 'posts/paginate/:page_num/:limit', to:'posts#paginate'

end
