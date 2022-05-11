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

### Nested JSON Objects
```rb
class UsersController < ApplicationController  
  
  class StaticData   
    EXCLUDE_COLUMNS = ['created_at', 'updated_at']
    COLUMNS = User.attribute_names - EXCLUDE_COLUMNS
  end
  
  def index
    users = User.select(StaticData::COLUMNS).all
    render :json => users, include: [:posts => {:only => [:id, :user_id, :title, :body], 
                                                include: [:comments => {:only => [:id, :body, :post_id, :user_id]}]}]

  end
```
```json
{
    "id": 4,
    "name": "Rep. Claud Kihn",
    "username": "rep.claudkihn",
    "email": "rep.claudkihn@gmail.com",
    "member": true,
    "posts": [
      {
        "id": 1,
        "user_id": 4,
        "title": "Waistcoat Venmo Letterpress Franzen Master Messenger Bag Flannel Yolo.",
        "body": "Totam omnis corporis impedit autem.",
        "comments": []
      },
      {
        "id": 56,
        "user_id": 4,
        "title": "Lomo Poutine Everyday Marfa Raw Denim Wayfarers.",
        "body": "Doloremque quia animi.",
        "comments": []
      },
      {
        "id": 91,
        "user_id": 4,
        "title": "Pop Up Sriracha Sustainable.",
        "body": "Et iusto laboriosam consequuntur atque quo.",
        "comments": [
          {
            "id": 18,
            "user_id": 40,
            "post_id": 91,
            "body": "Nemo quia earum voluptatibus fugiat."
          },
          {
            "id": 53,
            "user_id": 32,
            "post_id": 91,
            "body": "Sequi voluptas animi blanditiis debitis temporibus."
          },
          {
            "id": 63,
            "user_id": 10,
            "post_id": 91,
            "body": "Perspiciatis corporis asperiores et aliquam."
          },
          {
            "id": 65,
            "user_id": 3,
            "post_id": 91,
            "body": "Natus et soluta."
          }
        ]
      },
      {
        "id": 93,
        "user_id": 4,
        "title": "Kogi Ethical You Probably Haven't Heard Of Them.",
        "body": "Occaecati sequi laudantium vel veniam.",
        "comments": [
          {
            "id": 96,
            "user_id": 12,
            "post_id": 93,
            "body": "Distinctio esse ipsam quasi dolore."
          }
        ]
      }
    ]
  }
```