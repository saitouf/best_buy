# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ログイン
Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

# 商品タグ一覧
Tag.create([
  { name: 'ファッション' },
  { name: 'グルメ・飲料' },
  { name: '日用品・ヘルスケア' },
  { name: '美容・コスメ・香水' },
  { name: 'ベビー・キッズ' },
  { name: '家電・周辺機器' },
  { name: 'スポーツ・アウトドア' },
  { name: '車体・オートパーツ' },
  { name: '住まい・ペット・DIY' },
  { name: '本・音楽・ゲーム' },
  { name: 'おもちゃ・ホビー・グッズ' },
  { name: 'その他' }
])