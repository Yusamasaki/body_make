FactoryBot.define do
  factory :bmr do
    gender { '男性' }
    age { 27 }
    height { 157 }
    activity { 2 }
    
    association :user
  end
end
