class DeletePostIdFromTagsAndChangeNameToTagName < ActiveRecord::Migration[7.0]
  def change
    remove_column :tags, :post_id
    rename_column :tags, :tag, :tag_name
  end
end
