class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show]

  def index
    @items = Item.order(id: :desc).all
  end

  def show
    # 人気のチケット
    @items = Item.order(id: :desc).first(3)

    # メッセージ送信
    @message = Message.new

    # 予約
    @appointment = Appointment.new
  end

  def new
    @item = Item.new
    @item.item_available_japan_places.build
    now = Time.zone.now
    from = Time.zone.local(now.year, now.month, now.day, now.hour, 0)
    to = from + 1.hour
    @item.item_available_datetimes.build(from: from, to: to)
    #@item.item_available_datetime_forms.build  # 表示上は日付と時刻のフォームを別にしたい

    render layout: "mypage"
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      #redirect_to @item, notice: "チケットを登録しました"  # TODO: 日本語依存
      redirect_to mypage_items_path, notice: "チケットを登録しました"  # TODO: 日本語依存
    else
      # 最低限 1 つは入力ボックスをつける
      if @item.item_available_japan_places.size == 0
        @item.item_available_japan_places.build
      end
      if @item.item_available_datetimes.size == 0
        now = Time.zone.now
        from = Time.zone.local(now.year, now.month, now.day, now.hour, 0)
        to = from + 1.hour
        @item.item_available_datetimes.build(from: from, to: to)
      end

      render :new, layout: "mypage"
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit({ service_ids: [] }, :title, :detail, :execution_time, :price,
                                   item_available_datetimes_attributes: [:id, :from, :to, :_destroy ],
                                   item_available_japan_places_attributes: [:id, :japan_city_id, :_destroy ])
    end
end
