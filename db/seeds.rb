# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
hokaido = JapanPrefecture.find_or_create_by(code: "01", name: "北海道")
JapanPrefecture.find_or_create_by(code: "02", name: "青森県")
JapanPrefecture.find_or_create_by(code: "03", name: "岩手県")
JapanPrefecture.find_or_create_by(code: "04", name: "宮城県")
JapanPrefecture.find_or_create_by(code: "05", name: "秋田県")
JapanPrefecture.find_or_create_by(code: "06", name: "山形県")
JapanPrefecture.find_or_create_by(code: "07", name: "福島県")
ibaraki = JapanPrefecture.find_or_create_by(code: "08", name: "茨城県")
JapanPrefecture.find_or_create_by(code: "09", name: "栃木県")
JapanPrefecture.find_or_create_by(code: "10", name: "群馬県")
JapanPrefecture.find_or_create_by(code: "11", name: "埼玉県")
JapanPrefecture.find_or_create_by(code: "12", name: "千葉県")
tokyo = JapanPrefecture.find_or_create_by(code: "13", name: "東京都")
JapanPrefecture.find_or_create_by(code: "14", name: "神奈川県")
JapanPrefecture.find_or_create_by(code: "15", name: "新潟県")
JapanPrefecture.find_or_create_by(code: "16", name: "富山県")
JapanPrefecture.find_or_create_by(code: "17", name: "石川県")
JapanPrefecture.find_or_create_by(code: "18", name: "福井県")
JapanPrefecture.find_or_create_by(code: "19", name: "山梨県")
JapanPrefecture.find_or_create_by(code: "20", name: "長野県")
JapanPrefecture.find_or_create_by(code: "21", name: "岐阜県")
JapanPrefecture.find_or_create_by(code: "22", name: "静岡県")
JapanPrefecture.find_or_create_by(code: "23", name: "愛知県")
JapanPrefecture.find_or_create_by(code: "24", name: "三重県")
JapanPrefecture.find_or_create_by(code: "25", name: "滋賀県")
JapanPrefecture.find_or_create_by(code: "26", name: "京都府")
JapanPrefecture.find_or_create_by(code: "27", name: "大阪府")
JapanPrefecture.find_or_create_by(code: "28", name: "兵庫県")
JapanPrefecture.find_or_create_by(code: "29", name: "奈良県")
JapanPrefecture.find_or_create_by(code: "30", name: "和歌山県")
JapanPrefecture.find_or_create_by(code: "31", name: "鳥取県")
JapanPrefecture.find_or_create_by(code: "32", name: "島根県")
JapanPrefecture.find_or_create_by(code: "33", name: "岡山県")
JapanPrefecture.find_or_create_by(code: "34", name: "広島県")
JapanPrefecture.find_or_create_by(code: "35", name: "山口県")
JapanPrefecture.find_or_create_by(code: "36", name: "徳島県")
JapanPrefecture.find_or_create_by(code: "37", name: "香川県")
JapanPrefecture.find_or_create_by(code: "38", name: "愛媛県")
JapanPrefecture.find_or_create_by(code: "39", name: "高知県")
JapanPrefecture.find_or_create_by(code: "40", name: "福岡県")
JapanPrefecture.find_or_create_by(code: "41", name: "佐賀県")
JapanPrefecture.find_or_create_by(code: "42", name: "長崎県")
JapanPrefecture.find_or_create_by(code: "43", name: "熊本県")
JapanPrefecture.find_or_create_by(code: "44", name: "大分県")
JapanPrefecture.find_or_create_by(code: "45", name: "宮崎県")
JapanPrefecture.find_or_create_by(code: "46", name: "鹿児島県")
JapanPrefecture.find_or_create_by(code: "47", name: "沖縄県")

#
# 市区町村
#
JapanCity.find_or_create_by(japan_prefecture: ibaraki, code: "08220", name: "つくば市")
JapanCity.find_or_create_by(japan_prefecture: tokyo, code: "13121", name: "足立区")

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
if Item.count == 0
  Item.create(user: user1, execution_time: 120, price: 3000, detail: "ネイル全般なんでもやります！")
  Item.create(user: user2, execution_time: 30, price: 5000, detail: "霊能力を伝授し、能力開花へと導きます。")
  Item.create(user: user3, execution_time: 60, price: 10000, detail: "資金0、ノースキルでも30日で15万円稼ぐ方法を伝授！")
end

