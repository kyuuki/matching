# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  tab_date = $('.tab-date')                 # 日付切り替えタブ
  button_date = $('.p-items-search-tab p')  # 日付切り替え各ボタン
  # いくつか .p-items-serch-tab があるので注意。
  # TODO: デザイン完了後に名前を付ける

  select_service = $('[name=tab-service]')  # サービス内容選択
  select_area = $('[name=tab-area]')        # エリア (都道府県) 選択
  condition_tag = $('.selected-tab__item')  # 検索条件タグ

  # 日付切り替え処理
  button_date.click(->
    button_date.removeClass("active")
    $(this).addClass("active")

    conditions = get_conditions(condition_tag, tab_date)
    get_items(conditions)
  )

  # サービス内容選択処理
  select_service.change(->
    val = $(this).val()
    text = $(this).find("option:selected").text()

    return if val == ""

    # タグの View 変更
    condition_tag.prepend("<li class='tag-service' data-service=#{val}><a class='selected-tab__item-close'>#{text}</a></li>");

    # TODO: Cookie に検索条件を保持してもいいかも

    # 検索条件を View から取得
    conditions = get_conditions(condition_tag, tab_date)

    # 検索結果取得
    get_items(conditions)
  )

  # エリア (都道府県) 選択処理
  select_area.change(->
    val = $(this).val()
    text = $(this).find("option:selected").text()

    return if val == ""

    condition_tag.prepend("<li class='tag-area' data-area=#{val}><a class='selected-tab__item-close'>#{text}</a></li>");

    conditions = get_conditions(condition_tag, tab_date)
    get_items(conditions)
  )

  # 検索条件タグ削除処理
  $(document).on("click", ".selected-tab__item-close", ->
    $(this).parent().remove()

    conditions = get_conditions(condition_tag, tab_date)
    get_items(conditions)
  )

  # タグの View から検索条件取得
  get_conditions = (condition_tag, tab_date) ->
    services = [];
    japan_prefectures = [];
    condition_tag.find(".tag-service").each(() ->
      services.push($(this).data("service"))
    )
    condition_tag.find(".tag-area").each(() ->
      japan_prefectures.push($(this).data("area"))
    )
    if (tab_date != null)
      date = $(tab_date.find(".active")).data("date")

    { "services": services, "japan_prefectures": japan_prefectures, "date": date }

  # 検索条件を送信してチケット一覧取得
  get_items = (conditions) ->
    ajax_params = {}
    ajax_params["services"] = conditions["services"]
    ajax_params["japan_prefectures"] = conditions["japan_prefectures"]
    ajax_params["date"] = conditions["date"]
    $.ajax({
      type: "GET"
      url: "/items/list"
      timeout: 10000
      cache: true
      dataType: "html"
      data: ajax_params,
      success: (response) ->
        data = response;
        $("#list").html(data)
    })

