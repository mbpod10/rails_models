class TagSerializer < ApplicationSerializer
  attributes :id, :tag, :posts

  def posts
    object.post do |post|
      {
        title: post.title,
        body: post.body,
        username: post.user.username

      }
    end
  end
end
