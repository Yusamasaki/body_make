FactoryBot.define do
  factory :todaymeal_recipe do
    start_time { '2021-12-08' }
    amount { 2 }
    association :user
    association :timezone
    association :recipe
  end
end
