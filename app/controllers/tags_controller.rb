class TagsController < ApplicationController  
  def index
    @tags = Tag.all
    render json: @tags
  end
  
  def name_slug
    name = params[:name]
    tag = Tag.find_by(tag: name)
    render json: tag
  end
end