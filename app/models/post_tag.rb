class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  validates_uniqueness_of :post_id, scope: :tag_id
  validates_uniqueness_of :tag_id, scope: :post_id
end