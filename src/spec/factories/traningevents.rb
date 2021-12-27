FactoryBot.define do
  factory :traningevent do
    traning_name {"ベンチプレス"}
    bodypart_id { 1 }
    association :user
  end
end
