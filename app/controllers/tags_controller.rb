class TagsController < ApplicationController  
  def index
    @tags = Tag.all
    render json: @tags
  end
  
  def name_slug
    name = params[:name]
    @tag = Tag.find_by(tag_name: name)
    render json: @tag
  end
end