
20.times do |n|
	User.create!(
		email: "user#{n + 1}@email.com",
		password: "password",
		username: "user#{n + 1}"
	)
end
puts "User作成！(ユーザー数: #{User.count})"

# 管理者
Admin.create!(
  email: "admin@email.com",
  password: "password",
  username: "admin"
)
puts 'Admin作成！'

# -----基本設定関連-----
gender_array = ["男性", "女性"]
activity_array = [1.2, 1.375, 1.55, 1.725, 1.9]

User.all.each do |user|
	user.create_bmr!(
		gender: gender_array[rand(2)],
		age: rand(18..60),
		height: rand(157..180),
		activity: activity_array[rand(5)]
	)
end
puts 'Bmr作成！'

User.all.each do |user|
	user.create_targetweight!(
		now_body_weight: rand(80..100),
		goal_body_weight: rand(60..79),
		now_bodyfat_percentage: rand(25..30),
		goal_bodyfat_percentage: rand(10..24),
		beginning_date: Time.current,
		target_date: Time.current.since(6.month)
	)
end
puts 'Targetweight作成！'

Timezone.create!([ {time_zone: "朝食"}, {time_zone: "昼食"}, {time_zone: "夕食"}, {time_zone: "間食"},])
puts 'Timezone作成！'
