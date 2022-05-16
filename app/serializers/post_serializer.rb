class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :username, :user_id, :tags_count, :tags, :comments_count, :comments 

  def username 
    object.user.username
  end

  def comments
    object.comments.map do |comment|
      {
        id: comment.id,
        user_id: comment.user_id,
        post_id: comment.post_id,
        body: comment.body,      
        username: comment.user.username         
      }
    end
  end
  
 def tags
  object.tags.map do |tag|
   tag.tag
  end
 end
  
end
