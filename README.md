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
    render :json => users, include: [:posts => {:only => [:id, :user_id, :title, :body]}]
  end
end
```
```json
{
    "id": 2,
    "name": "Arturo Hilll",
    "username": "arturohilll",
    "email": "arturohilll@gmail.com",
    "member": false,
    "posts": [
      {
        "id": 31,
        "user_id": 2,
        "title": "Pbr&B Vinegar Kitsch Pickled.",
        "body": "Asperiores animi officia iste expedita id."
      },
      {
        "id": 63,
        "user_id": 2,
        "title": "Trust Fund Fingerstache Actually Mlkshk.",
        "body": "Commodi consequatur eos."
      },
      {
        "id": 70,
        "user_id": 2,
        "title": "Single Origin Coffee Kitsch Fixie Trust Fund Small Batch Asymmetrical Kale Chips.",
        "body": "Itaque voluptas laboriosam eos facere."
      },
      {
        "id": 84,
        "user_id": 2,
        "title": "Flannel Viral Marfa Humblebrag Brunch Fixie Keffiyeh Fashion Axe.",
        "body": "Voluptatem voluptates nisi."
      }
    ]
  }
```