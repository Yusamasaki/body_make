FactoryBot.define do
  factory :today_exercise do
    start_time { "2021-08-19" }
    exercise_time { "2021-08-19 12:29:00" }
    calorie { 1 }
    note { "MyString" }
  end
end
