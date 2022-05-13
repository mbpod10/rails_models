class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :tags, :comments_count, :user_id, :user, :comments 

  def user 
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
    {
      tag: tag.tag,
      id: tag.id
    }
  end
 end
  
  
end

# def comments
#   object.comments.map do |comment|
#     {
#       id: comment.id,
#       user_id: comment.user_id,
#       post_id: comment.post_id,
#       body: comment.body,       
#       user: {
#         username: comment.user.username,
#         posts: posts(comment.user)
#       }
#     }
#   end
# end