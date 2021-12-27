FactoryBot.define do
  factory :pfc_ratio do
    protein { 20 }
    fat { 20 }
    carbo { 60 }
    association :user
  end
end
