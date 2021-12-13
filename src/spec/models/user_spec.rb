require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前とメールアドレスとパスワードがあれば登録できる" do
    expect(FactoryBot.create(:user)).to be_valid
  end
  
  it "名前がなければ登録できない" do
   expect(FactoryBot.build(:user, username: "")).to_not be_valid 
  end
  
  it "メールアドレスが重複していたら登録できない" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid 
  end
  
  it "メールアドレスが重複していたら登録できない" do
    user1 = FactoryBot.create(:user, username: "user", email: "user@email.com")
    expect(FactoryBot.build(:user, username: "userA", email: user1.email)).to_not be_valid
  end
  
  it "パスワードがなければ登録できない" do
    expect(FactoryBot.build(:user, password: "")).to_not be_valid
  end

  it "password_confirmationとpasswordが異なる場合保存できない" do 
    expect(FactoryBot.build(:user, password: "password", password_confirmation: "passward")).to_not be_valid 
  end 
  
end
