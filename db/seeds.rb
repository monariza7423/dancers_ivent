# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: "barakamon.goto_life@i.softbank.jp", password: "8144kssk")

Tag.create([
  { name: "ブレイク"},
  { name: "ポップ"},
  { name: "ロック"},
  { name: "ヒップホップ"},
  { name: "ハウス"},
  { name: "フリースタイル"},
  ])