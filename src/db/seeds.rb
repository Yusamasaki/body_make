
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

# 運動カテゴリー
ExerciseCategory.create(name: "自転車")
ExerciseCategory.create(name: "コンディショニング")
ExerciseCategory.create(name: "歩行")
ExerciseCategory.create(name: "ランニング")
ExerciseCategory.create(name: "スポーツ")
puts 'Exercise_category作成！'

# 運動コンテンツ
ExerciseContent.create(content: "全般", mets: 7.5, exercise_category_id: 1)
ExerciseContent.create(content: "通勤", mets: 6.8, exercise_category_id: 1)
ExerciseContent.create(content: "モトクロス", mets: 8.5, exercise_category_id: 1)
ExerciseContent.create(content: "腕立て伏せ•腹筋•懸垂", mets: 8.0, exercise_category_id: 2)
ExerciseContent.create(content: "なわとび", mets: 12.3, exercise_category_id: 2)
ExerciseContent.create(content: "ストレッチ", mets: 2.3, exercise_category_id: 2)
ExerciseContent.create(content: "散歩", mets: 3.5, exercise_category_id: 3)
ExerciseContent.create(content: "競歩", mets: 6.5, exercise_category_id: 3)
ExerciseContent.create(content: "山を登る", mets: 6.3, exercise_category_id: 3)
ExerciseContent.create(content: "ジョギング", mets: 7.0, exercise_category_id: 4)
ExerciseContent.create(content: "ランニング", mets: 8.0, exercise_category_id: 4)
ExerciseContent.create(content: "トラック•チーム練習", mets: 10.0, exercise_category_id: 4)
ExerciseContent.create(content: "ゴルフ", mets: 4.8, exercise_category_id: 5)
ExerciseContent.create(content: "サッカー", mets: 7.0, exercise_category_id: 5)
ExerciseContent.create(content: "ソフトボール", mets: 4.0, exercise_category_id: 5)
puts 'Exercise_content作成！'

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

# -----トレーニング関連------

Traningtype.create!(
	[{traning_type: "バーベル種目"}, {traning_type: "ダンベル種目"}, {traning_type: "マシン種目"}, {traning_type: "自重種目"}]
)
puts 'Traningtype作成！'

Bodypart.create!(
	[{body_part: "胸", recovery_day: 2}, {body_part: "背中", recovery_day: 3}, {body_part: "脚", recovery_day: 3}, {body_part: "肩", recovery_day: 2}, {body_part: "腕", recovery_day: 2}, {body_part: "腹筋", recovery_day: 1}]
)
puts 'Bodypart作成！'

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
puts 'SubBodypart作成！'

Timezone.create!([ {time_zone: "朝食"}, {time_zone: "昼食"}, {time_zone: "夕食"}, {time_zone: "間食"},])
puts 'Timezone作成！'
