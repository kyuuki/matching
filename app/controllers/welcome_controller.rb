class WelcomeController < ApplicationController
  def index
    @items = Item.joins(:item_available_datetimes).merge(ItemAvailableDatetime.available_after(Time.zone.now())).order(id: :desc).first(6)
  end

  def about
  end

  def terms
  end
end
