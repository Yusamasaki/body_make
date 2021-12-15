FactoryBot.define do
  factory :todaymeal_recipe do
    amount { 2 }
    association :user
    association :timezone
    association :recipe
  end
end
