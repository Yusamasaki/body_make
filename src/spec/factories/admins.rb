FactoryBot.define do
  factory :admin do
    email { "admin@email.com" }
    password {"password"}
    password_confirmation {'password'}
  end
end
