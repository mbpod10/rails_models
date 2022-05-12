class PostSerializer < ApplicationSerializer
  attributes :id, :title, :body, :comments_count
  attribute :user
  has_many :comments
  
end
