FactoryBot.define do
  factory :traning_analysis do
    start_time { Time.current.to_date }
    total_load { 2000 }
    max_load { 100 }
    association :user
    association :traningevent
  end
end
