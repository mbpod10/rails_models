class TagSerializer < ApplicationSerializer
  attributes :id, :tag_name, :posts

  def posts
    object.posts.order("id").map do |post|
      {
        post_id: post.id,
        title: post.title,
        body: post.body,
        username: post.user.username,
        user_id: post.user.id        
      }
    end  
  end


end
