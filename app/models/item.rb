class Item < ActiveRecord::Base
  belongs_to :user
  has_many :item_services
  has_many :services, through: :item_services
  has_many :item_available_japan_places
  has_many :japan_cities, through: :item_available_japan_places
  accepts_nested_attributes_for :item_available_japan_places, reject_if: :all_blank, allow_destroy: true
  has_many :item_available_datetimes
  accepts_nested_attributes_for :item_available_datetimes, reject_if: :all_blank, allow_destroy: true

  has_many :appointments

  validates :title, presence: true
  validates :execution_time, presence: true
  validates :price, presence: true
  # http://qiita.com/haracane/items/6f6f59753595c6f6dec7
  validates :services, length: { minimum: 1 }
  validates :item_available_japan_places, length: { minimum: 1, maximum: 5 }
  validates :item_available_datetimes, length: { minimum: 1, maximum: 5 }

  scope :posted_by, ->(user) { where(user: user) }
  scope :valid, ->(now) { joins(:item_available_datetimes).merge(ItemAvailableDatetime.available_after(now)).where(available: true) }
end
