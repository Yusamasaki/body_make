FactoryBot.define do
  factory :meals_analysis do
    start_time { '2021-12-08' }
    association :user
  end
end
