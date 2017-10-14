class Mypage::ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:activate, :deactivate]

  def index
    @items = Item.where(user: current_user).order(id: :desc)

    render layout: "mypage"
  end

  def activate
    @item.available = true
    if @item.save
      redirect_to mypage_items_path
    else
      redirect_to mypage_items_path, notice: "再出品に失敗しました。"
    end
  end

  def deactivate
    @item.available = false
    if @item.save
      redirect_to mypage_items_path
    else
      redirect_to mypage_items_path, notice: "停止に失敗しました。"
    end
  end

  private
    def set_item
      @item = Item.where(user: current_user).find(params[:id])
    end
end
