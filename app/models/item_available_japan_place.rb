class ItemAvailableJapanPlace < ActiveRecord::Base
  belongs_to :item
  belongs_to :japan_city
end
