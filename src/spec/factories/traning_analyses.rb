FactoryBot.define do
  factory :traning_analysis do
    start_time { '2021-12-08' }
    total_load { 2000 }
    max_load { 100 }
    association :user
    association :traningevent
  end
end
