class Appointment < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates :item, presence: true
  validates :user, presence: true
  validates :datetime, presence: true

  scope :reserved, ->(user) { joins(:item).merge(Item.posted_by(user)) }
end
