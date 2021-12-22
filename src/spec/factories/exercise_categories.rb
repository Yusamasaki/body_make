FactoryBot.define do
  factory :exercise_category do
    name { "カテゴリー1" }

    trait :invalid do
      name { nil }
    end
  end
end
