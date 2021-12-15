FactoryBot.define do
  factory :todaymeal do
    amount { 2 }
    association :user
    association :timezone
    association :myfood
  end
end
