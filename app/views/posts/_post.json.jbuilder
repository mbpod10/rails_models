# json.extract! post, :id, :title, :body, :user_id, :created_at, :updated_at
# if params.fetch(:user, false).to_bool
#  json.user post.user, partial: 'users/user', as: :user
# end
# if params.fetch(:comments, false).to_bool
#  json.comments post.comments do |comment|
#   json.partial! "comments/comment", comment: comment
#  end
# end