FactoryBot.define do
  factory :targetweight do
    now_body_weight { 80 }
    goal_body_weight { 60 }
    now_bodyfat_percentage { 20 }
    goal_bodyfat_percentage { 10 }
    beginning_date { '2021-12-08' }
    target_date { '2022-12-08' }
    
    association :user
  end
end
