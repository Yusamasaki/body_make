FactoryBot.define do
  factory :user do
    username { "testuser1" }
    nickname { "testnickname" }
    email { "test@rmail.com" }
    password { "password" }
  end
end
