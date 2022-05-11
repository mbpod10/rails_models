# class Comment < ApplicationRecord
#   belongs_to :user, counter_cache: true
#   belongs_to :post, counter_cache: true
# end

class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
  # scope :with_user, ->(include) { includes(:user) if include.present? && include.to_bool }
  scope :with_user, ->(include) { includes(:user) }
 end
#  scope :agency_referrals, -> (id, city_town) 
#            { includes(client: :address).where(agency_id: id, 
#             'client.address.city_town' => city_town) }