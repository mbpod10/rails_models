class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :username, :avatar, :user_id, :tags_count, :tags, :comments_count, :comments 

  def username 
    object.user.username
  end

  def avatar
    object.user.avatar
  end

  def comments
    object.comments.map do |comment|
      {
        id: comment.id,
        user_id: comment.user_id,
        post_id: comment.post_id,
        body: comment.body,      
        username: comment.user.username,
        avatar: comment.user.avatar,
        created_at: comment.created_at.strftime("%m/%d/%Y @ %I:%M%p")
      }
    end
  end
  
 def tags
  object.tags.map do |tag|
   tag.tag_name
  end
 end
  
end
