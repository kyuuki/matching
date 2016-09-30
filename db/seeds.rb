# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"

#
# キャンペーンカテゴリ
#
services = [
  "ネイルカラー",
  "ネイルジェル",
  "ネイルスカルプチュア",
  "ヘアカット",
  "ヘアカラー",
  "ヘアパーマ",
  "シャンプ",
  "マッサージセラピー",
  "ヘアエステ",
  "フェイスエステ",
  "ボディエステ",
  "アイラッシュ（つけまつげ）"
]
services.each_with_index do |name, i|
  Service.find_or_create_by(name: name)
end

#
# 都道府県
#
CSV.foreach("db/local_governments.csv") do |row|
  next if not row[0] =~ /^[0-9]{6}$/
  code_prefecture = row[0][0..1]
  code_city = row[0][2..4]
  name_prefecture = row[1]
  name_city = row[2]

  if code_city == "000"
    #puts "都道府県: #{name_prefecture}"
    prefecture = JapanPrefecture.find_or_initialize_by(code: code_prefecture)
    prefecture.name = name_prefecture
    prefecture.save!
    #$pp prefecture
  else
    #puts "市区町村: #{name_city}"
    prefecture = JapanPrefecture.find_by(code: code_prefecture)
    city = JapanCity.find_or_initialize_by(japan_prefecture: prefecture, code: code_city)
    city.name = name_city
    city.save!
    #pp city
  end
end

hokaido = JapanPrefecture.find_by(code: "01")
ibaraki = JapanPrefecture.find_by(code: "08")
tokyo = JapanPrefecture.find_by(code: "13")
city1 = JapanCity.find_by(japan_prefecture: ibaraki, code: "220")
city2 = JapanCity.find_by(japan_prefecture: tokyo, code: "121")

#
# ユーザー (本番環境では削除)
#
if User.count == 0
  ju = JapanUser.create(last_name_kana: "イエサ", first_name_kana: "ロンコ", japan_prefecture: hokaido)
  user1 = User.create(email: "a@a.com", password: "aaaaaa",
              account_name: "abcdef",
              last_name: "家沙",
              first_name: "論子",
              sex: 2,
              birthday: "2000-01-01",
              address2: "択捉郡留別村",
              address3: "○○ビル 902",
              phone: "03-1234-5678",
              phone_mobile: "090-1234-5678",
              profile: "代官山で自分のプライベートサロンをしています。「自分の力で生きていきたい」「自分の個性を貫きたい」「自分に自信を持ち、自分の色を出したい」そんな【自分らしく生きる女性】のためにネイルを作っています。",
              profile_image: open("#{Rails.root}/public/images/prof_img.jpg"),
              japan_user: ju)
  ju = JapanUser.create(last_name_kana: "ノウジョウ", first_name_kana: "アミ", japan_prefecture: hokaido)
  user2 = User.create(email: "amiami@example.com", password: "aaaaaa",
              account_name: "amiami",
              last_name: "能條",
              first_name: "愛未",
              sex: 2,
              birthday: "1994-10-18",
              address2: "択捉郡留別村",
              address3: "○○ビル 902",
              phone: "03-1234-5678",
              phone_mobile: "090-1234-5678",
              profile: "「本物の霊能力の鑑定は由那先生」とまで言われる程の実績を持っているベテラン霊能者。 ",
              profile_image: open("#{Rails.root}/public/images/prof_img2.jpg"),
              japan_user: ju)
  ju = JapanUser.create(last_name_kana: "ナガシマ", first_name_kana: "セイラ", japan_prefecture: tokyo)
  user3 = User.create(email: "rarin@example.com", password: "aaaaaa",
              account_name: "rarin",
              last_name: "永島",
              first_name: "聖羅",
              sex: 2,
              birthday: "1994-10-18",
              address2: "足立区××",
              address3: "",
              phone: "03-1234-5678",
              phone_mobile: "090-1234-5678",
              profile: "自宅勤務歴10年以上。ソフトウェア開発の受託で生計を立てています。自主制作アプリで収入を増やしたい。投資で資産を増やしたい。ミニマムライフ実勢したい。",
              profile_image: open("#{Rails.root}/public/images/prof_img3.jpg"),
              japan_user: ju)
  User.create(email: "maimai@example.com", password: "aaaaaa")
  User.create(email: "asuka@example.com", password: "aaaaaa")
end

#
# チケット
#
# TODO: 他の変数に依存しているので、ここだけ独立して動かない
#
if Item.count == 0
  service1 = Service.find(1)
  service2 = Service.find(2)
  service3 = Service.find(3)

  item = Item.new(user: user1, execution_time: 120, price: 3000, title: "ネイル全般なんでもやります！",
              detail: "ワンカラーに左右1本づつアート付きのシンプルネイル アートは全て手描きのフラットアートが選べます。たくさんあるカラーから素敵な自分らしい色を選んで下さい。")
  item.services << service1
  item.services << service2
  item.item_available_datetimes.build(from: "2016-10-01 10:00", to: "2016-10-01 12:00")
  item.item_available_datetimes.build(from: "2016-10-01 14:00", to: "2016-10-01 17:00")
  item.item_available_japan_places.build(japan_city: city1)
  item.item_available_japan_places.build(japan_city: city2)
  item.save!

  item = Item.new(user: user2, execution_time: 30, price: 5000, title: "霊能力を伝授し、能力開花へと導きます。",
              detail: "あなたの代から7代まで祟られるか、しっかりと祓いを行って弁財天の眷属である白蛇様から施しを受けるかあなた自身が決めてください。")
  item.services << service2
  item.item_available_datetimes.build(from: "2016-01-01 00:00", to: "2016-01-01 00:00")
  item.item_available_datetimes.build(from: "2017-01-01 00:00", to: "2017-01-01 00:00")
  item.item_available_japan_places.build(japan_city: city1)
  item.save!

  item = Item.new(user: user3, execution_time: 60, price: 10000, title: "資金0、ノースキルでも30日で15万円稼ぐ方法を伝授！",
              detail: "副業で月100万円は当たり前。個人が企業を出しぬけるのが当たり前。ココならば安心の高収入が手に入ります。登録件数も激増中！")
  item.services << service3
  item.item_available_datetimes.build(from: "2020-01-01 00:00", to: "2020-01-01 00:00")
  item.item_available_japan_places.build(japan_city: city1)
  item.save!
end

