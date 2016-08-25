class WelcomeController < ApplicationController
  def index
    @items = Item.order(id: :desc).first(6)
  end

  def about
  end

  def terms
  end
end
