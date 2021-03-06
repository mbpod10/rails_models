class PostsController < ApplicationController 

  def index
    @posts = Post.all.order(:id)         
      
    render json: @posts
    # render json: {
    #               data: ActiveModelSerializers::SerializableResource.new(@posts, each_serializer: PostSerializer),
    #               message: ['Post list fetched successfully'],
    #               status: 200,
    #               type: 'Success'
    #             }    
  end  
  
  def get_user_posts
    user = User.find(params[:id])
    posts = user.posts.all    
    render json: user, include: [:posts => {:only => [:id, :user_id, :title, :body]}]
  end
  
  def show        
    @post = Post.find(params[:id])
    render json: {data: @post}
  end

  def paginate
    limit = params[:limit].to_i
    page_num = params[:page_num]
    page = page_num.to_i - 1
    d = limit * page
    @posts = Post.all.order(:id).limit(d).offset(page)   
    render json: @posts    
  end
 

end