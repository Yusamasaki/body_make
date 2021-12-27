FactoryBot.define do
  factory :bodyweight do
    start_time { '2021-12-08' }
    association :user
  end
end
