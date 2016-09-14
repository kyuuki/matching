class Item < ActiveRecord::Base
  belongs_to :user
  has_many :item_services
  has_many :services, through: :item_services
  has_many :item_available_datetimes
  accepts_nested_attributes_for :item_available_datetimes, reject_if: :all_blank, allow_destroy: true
  has_many :item_available_japan_places
  accepts_nested_attributes_for :item_available_japan_places, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :execution_time, presence: true
  validates :price, presence: true
end
