class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :comments_count, :user_id, :user, :comments 

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
        user: {
          username: comment.user.username,
          posts: posts(comment.user)
        }
      }
    end
  end

  def posts(object)
    object.posts.map do |post|
      {
        id: post.user.id,
        user: post.user.username,
        title: post.title
      }
    end
  end

  
end
