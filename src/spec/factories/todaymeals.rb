FactoryBot.define do
  factory :todaymeal do
    start_time { '2021-12-08' }
    amount { 2 }
    association :user
    association :timezone
    association :myfood
  end
end
