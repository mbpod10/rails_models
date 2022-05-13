class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :tags_count, :integer
  end
end
