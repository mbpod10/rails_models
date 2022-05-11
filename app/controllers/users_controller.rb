class UsersController < ApplicationController
  
  def index
    exclude_columns = ['created_at', 'updated_at']
    columns = User.attribute_names - exclude_columns
    @users = User.select(columns)
    render :json => @users
  end
  
  def show 
    exclude_columns = ['created_at', 'updated_at']
    columns = User.attribute_names - exclude_columns
    @user = User.select(columns).find(params[:id])
    render :json => @user
  end
  
  def update
    puts params
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    bool = !@user.member
    @user.member = bool
    @user.save
    render :json => @user
  end

end