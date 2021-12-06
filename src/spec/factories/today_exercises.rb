FactoryBot.define do
  factory :today_exercise do
    start_time { "2021-08-19" }
    exercise_time_hour { 1 }
    exercise_time_min { 0 }
    note { "MyString" }
  end
end
