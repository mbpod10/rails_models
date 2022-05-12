class UserSerializer < ApplicationSerializer
  attributes :id, :username, :email
  attribute :posts
end
