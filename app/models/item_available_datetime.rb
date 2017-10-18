class ItemAvailableDatetime < ActiveRecord::Base
  belongs_to :item

  validates :from, presence: true
  validates :to, presence: true

  scope :available_after, ->(time) { where(from: time.."2999-12-31 23:59:59") }

  def to_string_short
    if from.beginning_of_day == to.beginning_of_day
      "#{from.strftime("%m/%d %H:%M")} - #{to.strftime("%H:%M")}"
    else
      "#{from.strftime("%m/%d %H:%M")} - #{to.strftime("%m/%d %H:%M")}"
    end
  end
end
