```
$ rails g migration AddUserIdBodyAndTitleToPosts
```
```rb
class AddUserIdBodyAndTitleToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :title, :string
    add_column :posts, :body, :string
  end
end
```

```
$ rails db:migrate
// If not sufficient migration then run 
$ rails db:rollback
```
```
// Drop Database, create database, reseed
$ rails db:reset
```

### Nested JSON Objects
- Create serializers
```rb
gem 'active_model_serializers'
```
```
$ bundle install
$ rails generate serializer post
```
This creates a serializer file in app/serializers/post_serializer.rb
```rb
# post_serializer.rb
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :tags_count, :tags, :user_id, :user, :comments_count, :comments 

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
```

```rb
# posts_controller.rb
class PostsController < ApplicationController 

  def index
    @posts = Post.all.order(:id)         
      
    render json: 
      {
        data: ActiveModelSerializers::SerializableResource.new(@posts, each_serializer: PostSerializer),
        message: ['Post list fetched successfully'],
        status: 200,
        type: 'Success'
      }    
  end
end  
```
```json
{
  "data": [
    {
      "id": 1,
      "title": "Mixtape Fingerstache Freegan Poutine Cliche.",
      "body": "Consequatur eos voluptas facere nemo dolores.",
      "tags_count": 2,
      "tags": [
        {
          "tag": "Nature",
          "id": 1
        },
        {
          "tag": "Trees",
          "id": 9
        }
      ],
      "user_id": 1,
      "user": "uteschumm",
      "comments_count": 3,
      "comments": [
        {
          "id": 4,
          "user_id": 1,
          "post_id": 1,
          "body": "Ea perspiciatis nostrum maxime est facilis.",
          "username": "uteschumm"
        },
        {
          "id": 18,
          "user_id": 5,
          "post_id": 1,
          "body": "Voluptatem et ipsam.",
          "username": "sherlydibbertii"
        },
        {
          "id": 32,
          "user_id": 3,
          "post_id": 1,
          "body": "Voluptatem voluptatem qui fuga.",
          "username": "kiesharutherford"
        }
      ]
    }, ...
  ]
}
```
[counter_cache:](https://guides.rubyonrails.org/association_basics.html#:~:text=4.1.2.3%20%3Acounter_cache,Consider%20these%20models%3A)true