FactoryBot.define do
  factory :exercise_category do
    name { "カテゴリー" }

    trait :invalid do
      name { nil }
    end
  end

  factory :category1, class: ExerciseCategory do
    name { "カテゴリー1" }
  end

  factory :category2, class: ExerciseCategory do
    name { "カテゴリー2" }
  end
end
