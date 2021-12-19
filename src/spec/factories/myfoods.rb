FactoryBot.define do
  factory :myfood do
    food_name { "バナナ" }
    calorie { 100 }
    protein { 10 }
    fat { 10 }
    carbo { 10 }
    sugar { 10 }
    dietary_fiber { 10 }
    salt { 10 }
    association :user
  end
end
