class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments
  
  has_many :post_tags
  has_many :tags, through: :post_tags
end