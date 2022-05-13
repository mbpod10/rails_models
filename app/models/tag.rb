class Tag < ApplicationRecord
  belongs_to :post, counter_cache: true
end