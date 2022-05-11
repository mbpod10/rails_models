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