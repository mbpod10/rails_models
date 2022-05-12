class PostsController < ApplicationController 

  def index
    posts = Post.all
    render json: posts, 
                        # include: [:user => {:only => [:id, :username]}],
                        include: [:comments => {:only => [:body, :user_id, :post_id], 
                        include: [:user => {:only => [:id, :username, :post_count]}]}]
  end

  
  def get_user_posts
    user = User.find(params[:id])
    posts = user.posts.all    
    render json: user, include: [:posts => {:only => [:id, :user_id, :title, :body]}]
  end
  
  # def show  
  #   @posts = Post.select('*')
  #                       .joins(:users).where('user.id = post.user_id')
  #   render json: @posts
  # end

  render :json => @users, include: [:posts => {:only => [:id, :user_id, :title, :body, :comments_count], 
    include: [:comments => {:only => [:id, :body, :post_id, :user_id, :comments]}]}]

  def show  
    post = Post.find(params[:id])
    render :json => post, include: [:user => {:only => [:id, :username]},
                          include: [:comments => {:only => [:id, :body, :comments]}]]



  end
 

end