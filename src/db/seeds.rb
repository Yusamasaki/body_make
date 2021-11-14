
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
		mets: rand(1..3.9).floor(1),
		exercise_category_id: rand(1..3)
	)
end

puts 'sample exercise_cotent created!'

Traningtype.create!(
	[{traning_type: "バーベル種目"}, {traning_type: "ダンベル種目"}, {traning_type: "マシン種目"}, {traning_type: "自重種目"}]
)

Bodypart.create!(
	[{body_part: "胸"}, {body_part: "背中"}, {body_part: "脚"}, {body_part: "肩"}, {body_part: "腕"}, {body_part: "腹筋"}]
)

SubBodypart.create(
	[
		{sub_body_part: "大胸筋上部", bodypart_id: 1}, {sub_body_part: "大胸筋中部", bodypart_id: 1}, {sub_body_part: "大胸筋下部", bodypart_id: 1},
	  {sub_body_part: "僧帽筋上部", bodypart_id: 2}, {sub_body_part: "僧帽筋中部", bodypart_id: 2}, {sub_body_part: "僧帽筋下部", bodypart_id: 2}, {sub_body_part: "広背筋上部", bodypart_id: 2}, {sub_body_part: "広背筋下部", bodypart_id: 2},
		{sub_body_part: "大腿四頭筋", bodypart_id: 3}, {sub_body_part: "大腿二頭筋(ハムストリング)", bodypart_id: 3}, {sub_body_part: "下腿三頭筋(ふくらはぎ)", bodypart_id: 3},
		{sub_body_part: "三角筋前部", bodypart_id: 4}, {sub_body_part: "三角筋側部", bodypart_id: 4}, {sub_body_part: "三角筋後部", bodypart_id: 4},
		{sub_body_part: "上腕三頭筋", bodypart_id: 5}, {sub_body_part: "上腕二頭筋", bodypart_id: 5},
		{sub_body_part: "腹横筋", bodypart_id: 6}, {sub_body_part: "内腹斜筋", bodypart_id: 6}, {sub_body_part: "外腹斜筋", bodypart_id: 6}, {sub_body_part: "腹直筋", bodypart_id: 6}
	]
)