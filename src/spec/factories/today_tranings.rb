FactoryBot.define do
  factory :today_traning do
    traning_weight { 100}
    traning_reps { 10 }
    traning_note { "テスト" }
    association :user
    association :traningevent
  end
end
