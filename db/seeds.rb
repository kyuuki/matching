# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# ユーザー (本番環境では削除)
#
if User.count == 0
  User.create(email: "a@a.com", password: "aaaaaa")
  User.create(email: "amiami@example.com", password: "aaaaaa")
  User.create(email: "rarin@example.com", password: "aaaaaa")
  User.create(email: "maimai@example.com", password: "aaaaaa")
  User.create(email: "asuka@example.com", password: "aaaaaa")
end

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
ibaraki = JapanPrefecture.find_or_create_by(code: "08", name: "茨城県")
tokyo = JapanPrefecture.find_or_create_by(code: "13", name: "東京都")

#
# 市区町村
#
JapanCity.find_or_create_by(japan_prefecture: ibaraki, code: "08220", name: "つくば市")
JapanCity.find_or_create_by(japan_prefecture: tokyo, code: "13121", name: "足立区")

