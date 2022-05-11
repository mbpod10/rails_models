class UsersController < ApplicationController  
  
  class StaticData   
    EXCLUDE_COLUMNS = ['created_at', 'updated_at']
    COLUMNS = User.attribute_names - EXCLUDE_COLUMNS
  end
  
  def index
    @users = User.select(StaticData::COLUMNS).all
    render :json => @users, include: [:posts => {:only => [:id, :user_id, :title, :body, :comments_count], 
                                                include: [:comments => {:only => [:id, :body, :post_id, :user_id]}]}]

  end
  
  def show   
    @user = User.select(StaticData::COLUMNS).find(params[:id])
    render :json => @user, include: [:posts => {:only => [:id, :user_id, :title, :body, :comments_count], 
                                                include: [:comments => {:only => [:id, :body, :post_id, :user_id]}]}]
  end
  
  def update
    puts params
    @user = User.select(StaticData::COLUMNS).find(params[:id])
    @user.update(
      name: params[:name], 
      username: params[:username], 
      email: params[:email], 
      member: params[:member]    
    )
    @user.save
    render :json => @user
  end
  
  def toggle_member
    @user = User.select(StaticData::COLUMNS).find(params[:id])
    bool = !@user.member
    @user.member = bool
    @user.save
    render :json => @user
  end

end