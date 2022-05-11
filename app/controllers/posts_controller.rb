class PostsController < ApplicationController 

  # def index
  #   posts = Post.all
  #   render json: posts, include: [:user => {:only => [:id, :username]}]
  # end
  def index

  
    # user = params.fetch(:user, nil)
    # comments = params.fetch(:comments, nil)
    # @posts = Post.with_user(user).with_comments(comments).all
    # User.joins(:profiles).merge(Profile.joins(:skills))
    # @posts = Post.joins(:user).joins(:comments)
    # @posts = Post.with_user(User.all.id)
    # render json: @posts, include: [:user => {:only => [:id, :username]}]

    # post = Post.first
    # Book.where(author: author)
    # Author.joins(:books).where(books: { author: author })

    # @posts = Post.joins(:user).where(user: {user: post})

    # render json: @posts
    'SELECT * FROM "posts"
        INNER JOIN "users" ON "users"."id" = "posts"."user_id" 
          INNER JOIN "comments" ON "comments"."post_id" = "posts"."id"'

    # @posts = Post.select('*').joins(:user).joins(:comments)
    # @posts = Post.joins(:user, :comments)
    # @posts = Post.joins(:user).left_joins(:comments)
    # @posts = Post.joins(user: :comments)
    # @posts = Post.joins(user: [{:comments}])
    # @posts = User.joins(:posts, :comments)
    # @posts = User.joins(posts: [:comments])
    @posts = Post.select('posts.id, posts.user_id, title, posts.body, 
                          users.username, posts.comments_count, users.posts_count, comments')   
                  .joins(:user)
                  .joins(:comments)
    render json: @posts
    
  end
  
  def get_user_posts
    user = User.find(params[:id])
    posts = user.posts.all    
    render json: user, include: [:posts => {:only => [:id, :user_id, :title, :body]}]
  end
  
  def show
    # post = Post.find(params[:id])
    # user = post.user
    # comments = post.comments.joins(:user)
    # puts post
    # puts user
    # puts comments
    # render json: { post , user}
    @posts = Post.select('*')
                        .joins(:users).where('user.id = post.user_id')
    render json: @posts
  end

end