class CommentSerializer < ApplicationSerializer
  attributes :id, :user_id, :post_id, :body
  attribute :user
  belongs_to :user
end
