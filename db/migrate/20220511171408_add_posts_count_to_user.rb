class AddPostsCountToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :posts_count, :integer
    add_column :posts, :comments_count, :integer
  end
end
