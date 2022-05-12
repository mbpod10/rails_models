# class Post < ApplicationRecord
#   belongs_to :user, counter_cache: true
#   # has_many :comments, -> { order(id: :desc)}, through: :user 
#   has_many :comments, -> { order(id: :desc)}, inverse_of: :post, dependent: :destroy
# end

# class Post < ApplicationRecord
#   belongs_to :user, counter_cache: true
#   has_many :comments, -> { order(id: :desc)}, inverse_of: :post, dependent: :destroy
#   # scope :with_user, ->(include) { includes(:user) if include.present? && include.to_bool }
#   # scope :with_comments, ->(include) { includes(:comments) if include.present? && include.to_bool }
#   # scope :with_user, ->(include) { includes(:user) }
#   # scope :with_comments, ->(include) { includes(:comments) }

#   scope :with_published_articles, -> { includes(:articles).where(articles: { published: true}) }

#   scope :with_user, -> { includes(:user).where(user_id: id) }

# end

# class Post < ApplicationRecord
#   belongs_to :user, counter_cache: true
#   has_many :comments, -> { order(created_at: :desc)}, inverse_of: :post, dependent: :destroy
#   # scope :with_comments, ->(include) { includes(:comments) if include.present? && include.to_bool }
#   scope :with_comments, ->(include) { includes(:comments) }
#  end
# class Post < ApplicationRecord
#   belongs_to :user, counter_cache: true
#   has_many :comments, -> { order(created_at: :desc)}, inverse_of: :post, dependent: :destroy
#   scope :with_comments, ->(include) { includes(:comments) if include.present? && include.to_bool }
#  end
class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, -> { order(created_at: :desc)}, inverse_of: :post, dependent: :destroy
  scope :with_user, ->(include) { includes(:user) }
  # scope :with_comments, ->(include) { includes(:comments) if include.present? && include.to_bool }
  # scope :with_user, -> (user) {where('user.id = post.user_id')}
 end