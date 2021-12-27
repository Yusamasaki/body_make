FactoryBot.define do
  factory :recipe do
    recipe_name { "豚肉と野菜炒め" }
    calorie { 500 }
    protein { 50 }
    fat { 50 }
    carbo { 50 }
    sugar { 50 }
    dietary_fiber { 50 }
    salt { 50 }
    association :user
  end
end
