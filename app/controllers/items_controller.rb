class ItemsController < ApplicationController
  before_action :set_campaign, only: [:show]

  def index
    @items = Item.order(id: :desc).all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:execution_time, :place, :service_id, :detail, :price)
    end
end
