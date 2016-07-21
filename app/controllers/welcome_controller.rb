class WelcomeController < ApplicationController
  def index
    @items = Item.order(id: :desc).first(6)
  end
end
