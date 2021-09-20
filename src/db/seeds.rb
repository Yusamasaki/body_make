# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー
User.create!( 
	email: "user@email.com",
	password: "password",
	username: "user"
)

puts 'sample user created!'

# 管理者
Admin.create!(
  email: "admin@email.com",
  password: "password",
  username: "admin"
)

puts 'sample admin created!'

# 運動カテゴリー
3.times do |n|
  ExerciseCategory.create!(
		name: "運動カテゴリー#{n + 1}"
	)
end

puts 'sample exercise_category created!'

# 運動コンテンツ
30.times do |n|
	ExerciseContent.create!(
		content: "運動コンテンツ#{n + 1}",
		exercise_category_id: rand(1..3)
	)
end

puts 'sample exercise_cotent created!'
