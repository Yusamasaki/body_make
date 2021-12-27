FactoryBot.define do
  factory :today_exercise do
    start_time { Date.current }
    exercise_time_hour { 1 }
    exercise_time_min { 5 }
    body_weight {65.0}
    note { "note1" }
    association :user
  end
end
