class PostsController < ApplicationController 

  def index
    posts = Post.all
    render json: posts, include: [:user => {:only => [:id, :username]}]
  end
  
  def get_user_posts
    user = User.find(params[:id])
    posts = user.posts.all    
    render json: user, include: [:posts => {:only => [:id, :user_id, :title, :body]}]
  end

end