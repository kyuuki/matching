class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show]

  def index
    @items = Item.all.order(id: :desc)
  end

  def list
    # 検索条件: サービス内容
    param_services = params["services"]
    # 検索条件: 提供可能場所 (これは過去のを含めると大量)
    param_date = params["date"]
    # 検索条件: 提供可能日時 (これは多くならない)
    param_japan_prefectures = params["japan_prefectures"]

    # TODO: 検索条件のパラメータをどうするか
    query = Item.includes(:services, :item_available_datetimes, :japan_cities)
    if not (param_services.nil? or param_services.size == 0)
      query = query.where(services: {id: param_services})
    end
    if not param_date.nil?
      now = Time.zone.now
      if param_date == "today"
        query = query.where(item_available_datetimes: { from: now.beginning_of_day..now.end_of_day })
      elsif param_date == "tomorrow"
        query = query.where(item_available_datetimes: { from: now.tomorrow.beginning_of_day..now.tomorrow.end_of_day })
      end
    end
    if not (param_japan_prefectures.nil? or param_japan_prefectures.size == 0)
      query = query.where(japan_cities: { japan_prefecture_id: param_japan_prefectures })
    end

    @items = query.order(id: :desc)

    render layout: false
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

    unless current_user.can_sell_item?
     flash.now[:notice] = "チケットを出品するにはプロフィールの登録が必要です。"  # TODO: 多言語
    end

    render layout: "mypage"
  end

  def create
    unless current_user.can_sell_item?
      redirect_to edit_user_registration_path(current_user), notice: "チケットを出品するにはプロフィールの登録が必要です。"  # TODO: 多言語
      return
    end

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
