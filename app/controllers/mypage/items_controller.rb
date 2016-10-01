class Mypage::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.where(user: current_user).order(id: :desc)

    render layout: "mypage"
  end
end
