FactoryBot.define do
  factory :recipefood do
    amount { 2 }
    association :user
    association :recipe
    association :myfood
  end
end
