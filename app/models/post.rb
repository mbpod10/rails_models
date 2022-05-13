class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments #, counter_cache: true
  has_many :tags, counter_cache: true
end