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

## Many-To-Many Relationships
- Create many to many relationship of Posts and Tags
```
$ rails g migration CreatePostTags    
```
```rb
class CreatePostTags < ActiveRecord::Migration[7.0]
  def change
    create_table :post_tags do |t|
      t.references :tag, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
```
references means that the the column will be given an _id suffix column that will hold an integer as a foreign key. It will add relational integrity with sql REFERENCES, and indexing.
```
$ rails db:migrate
```
```rb
# schema.rb
  create_table "post_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id"
    t.index ["tag_id"], name: "index_post_tags_on_tag_id"
  end
```
```rb
# app/models/post_tag.rb
class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end
# app/models/post.rb
class Post < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags
end
# app/models/tag.rb
class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags, counter_cache: true
end
```
```rb
# seeds.rb
25.times do
  PostTag.create(
    tag_id: rand(1..Tag.count),
    post_id: rand(1..Post.count)
  )
end
puts "Created #{PostTag.count} PostTags"
```
```
$ rails c
$ tag = Tag.find(8)
$ tag.posts
```
```rb
[#<Post:0x00007f7d98dd3f20
  id: 20,
  created_at: Mon, 16 May 2022 15:52:03.778211000 UTC +00:00,
  updated_at: Mon, 16 May 2022 15:52:03.778211000 UTC +00:00,
  user_id: 10,
  title: "Twee Marfa Thundercats Microdosing Swag Chillwave Keytar Venmo.",
  body: "Molestias rerum eveniet.",
  comments_count: 2,
  tags_count: 0>,
 #<Post:0x00007f7d98f1f7a8
  id: 10,
  created_at: Mon, 16 May 2022 15:52:03.685514000 UTC +00:00,
  title: "Kickstarter Truffaut Pabst Brunch Brooklyn.",
  body: "Alias blanditiis atque consequuntur.",
  comments_count: 1,
  tags_count: 0>,
 #<Post:0x00007f7d98f1f6b8
  id: 12,
  created_at: Mon, 16 May 2022 15:52:03.702858000 UTC +00:00,
  updated_at: Mon, 16 May 2022 15:52:03.702858000 UTC +00:00,
  user_id: 2,
  title: "Hoodie Chartreuse Photo Booth Squid Everyday Plaid.",
  body: "Et modi dolorum suscipit.",
  comments_count: 2,
  tags_count: 0>]
```