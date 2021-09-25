
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

Traningtype.create!(
	[
		{
			traning_type: "バーベル種目"
		},
		{
			traning_type: "ダンベル種目"
		},
		{
			traning_type: "マシン種目"
		},
		{
			traning_type: "自重種目"
		}
	]
)