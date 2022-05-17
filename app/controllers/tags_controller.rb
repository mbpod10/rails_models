class TagsController < ApplicationController  
  def index
    @tags = Tag.all
    render json: @tags
  end
  
  def name_slug
    name = params[:name]
    @tag = Tag.find_by(tag_name: name)
    # @tag.posts.order("id")
    # puts @tag.posts
   
    render json: @tag
  end
  
  def default_serializer_options
    {
      root: false
    }
  end
end