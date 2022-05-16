class TagSerializer < ApplicationSerializer
  attributes :id, :tag_name, :posts

  def posts
    object.posts.map do |post|
      {
        title: post.title,
        body: post.body,
        username: post.user.username
      }
    end
  end
end
