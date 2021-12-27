FactoryBot.define do
  factory :exercise_content do
    content { "コンテンツ1" }
    mets { 1.1 }
    association :exercise_category
  end
end
