
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

# -----基本設定関連-----

Bmr.create!(
	user_id: 1,
	gender: "男性",
	age: 27,
	height: 157,
	activity: 1.725
)

Targetweight.create!(
	user_id: 1,
	now_body_weight: 80,
	goal_body_weight: 60,
	now_bodyfat_percentage: 20,
	goal_bodyfat_percentage: 10,
	beginning_date: Time.current,
	target_date: Time.current.since(6.month)
)

# -----トレーニング関連------

Traningtype.create!(
	[{traning_type: "バーベル種目"}, {traning_type: "ダンベル種目"}, {traning_type: "マシン種目"}, {traning_type: "自重種目"}]
)

Bodypart.create!(
	[{body_part: "胸", recovery_day: 2}, {body_part: "背中", recovery_day: 3}, {body_part: "脚", recovery_day: 3}, {body_part: "肩", recovery_day: 2}, {body_part: "腕", recovery_day: 2}, {body_part: "腹筋", recovery_day: 1}]
)

SubBodypart.create!(
	[
		{sub_body_part: "大胸筋上部", recovery_day: 2, bodypart_id: 1}, {sub_body_part: "大胸筋中部", recovery_day: 2, bodypart_id: 1}, {sub_body_part: "大胸筋下部", recovery_day: 2, bodypart_id: 1},
	  {sub_body_part: "僧帽筋上部", recovery_day: 2, bodypart_id: 2}, {sub_body_part: "僧帽筋中部", recovery_day: 3, bodypart_id: 2}, {sub_body_part: "僧帽筋下部", recovery_day: 3, bodypart_id: 2}, {sub_body_part: "広背筋上部", recovery_day: 3, bodypart_id: 2}, {sub_body_part: "広背筋下部", recovery_day: 3, bodypart_id: 2}, {sub_body_part: "脊柱起立筋", recovery_day: 3, bodypart_id: 2},
		{sub_body_part: "大腿四頭筋", recovery_day: 3, bodypart_id: 3}, {sub_body_part: "大腿二頭筋(ハムストリング)", recovery_day: 3, bodypart_id: 3}, {sub_body_part: "下腿三頭筋(ふくらはぎ)", recovery_day: 1, bodypart_id: 3}, {sub_body_part: "大臀筋(お尻)", recovery_day: 2, bodypart_id: 3},
		{sub_body_part: "三角筋前部", recovery_day: 2, bodypart_id: 4}, {sub_body_part: "三角筋側部", recovery_day: 2, bodypart_id: 4}, {sub_body_part: "三角筋後部", recovery_day: 2, bodypart_id: 4},
		{sub_body_part: "上腕三頭筋", recovery_day: 2, bodypart_id: 5}, {sub_body_part: "上腕二頭筋", recovery_day: 2, bodypart_id: 5},
		{sub_body_part: "腹横筋", recovery_day: 1, bodypart_id: 6}, {sub_body_part: "内腹斜筋", recovery_day: 1, bodypart_id: 6}, {sub_body_part: "外腹斜筋", recovery_day: 1, bodypart_id: 6}, {sub_body_part: "腹直筋", recovery_day: 1, bodypart_id: 6}
	]
)

Traningevent.create!(
	[
		{traning_name: "ベンチプレス", subbodypart_id: 2, bodypart_id: 1, traningtype_id: 1, user_id: 1},
		{traning_name: "デッドリフト", subbodypart_id: 5, bodypart_id: 2, traningtype_id: 1, user_id: 1},
		{traning_name: "スクワット", subbodypart_id: 11, bodypart_id: 3, traningtype_id: 1, user_id: 1},
		{traning_name: "バーベルショルダープレス", subbodypart_id: 14, bodypart_id: 4, traningtype_id: 1, user_id: 1},
		{traning_name: "バーベルカール", subbodypart_id: 18, bodypart_id: 5, traningtype_id: 1, user_id: 1}
	]
)


Timezone.create!([ {time_zone: "朝食"}, {time_zone: "昼食"}, {time_zone: "夕食"}, {time_zone: "間食"},])

30.times do |n|
	Myfood.create!(
		user_id: 1,
		food_name: "食品#{n + 1}",
		calorie: rand(100),
		protein: rand(100),
		fat: rand(100),
		carbo: rand(100),
		sugar: rand(100),
		dietary_fiber: rand(100),
		salt: rand(100)
	)
end

30.times do |n|
	Recipe.create!(
		user_id: 1,
		recipe_name: "レシピ#{n + 1}"
	)
end