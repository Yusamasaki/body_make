FactoryBot.define do
  factory :user do
    username {"user"}
    sequence(:email) { |n| "user#{n}@email.com"}
    password {"password"}
    password_confirmation {'password'}
  end
end
