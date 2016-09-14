class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.order(id: :desc).all
  end

  def show
    # 人気のチケット
    @items = Item.order(id: :desc).first(3)

    # メッセージ送信
    @message = Message.new
  end

  def new
    @item = Item.new
    @item.item_available_japan_places.build
    @item.item_available_datetimes.build(from: Time.zone.now, to: Time.zone.now)
    #@item.item_available_datetime_forms.build
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
      params.require(:item).permit({ service_ids: [] }, :title, :detail, :execution_time, :price,
                                   item_available_datetimes_attributes: [:id, :from, :to ],
                                   item_available_japan_places_attributes: [:id, :japan_city_id ])
    end
end
