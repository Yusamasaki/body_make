require 'rails_helper'

RSpec.describe Bmr, type: :model do
  let(:bmr) { FactoryBot.create(:bmr) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        bmr = Bmr.reflect_on_association(:user)
        expect(bmr.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "基本登録" do
    context "genderの存在が" do
      it "あれば有効な状態であること" do
        expect(bmr).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bmr.gender = nil
        bmr.valid?
        expect(bmr.errors[:gender]).to include('を入力してください')
      end
    end
    context "ageの存在が" do
      it "あれば有効な状態であること" do
        expect(bmr).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bmr.age = nil
        bmr.valid?
        expect(bmr.errors[:age]).to include('を入力してください')
      end
      
      it '200以内であれば有効であること' do
        bmr.age = 200.0
        expect(bmr).to be_valid
      end
    end
    context "heightの存在が" do
      it "あれば有効な状態であること" do
        expect(bmr).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bmr.height = nil
        bmr.valid?
        expect(bmr.errors[:height]).to include('を入力してください')
      end
      
      it '300以内であれば有効であること' do
        bmr.height = 300.0
        expect(bmr).to be_valid
      end
      
    end
    context "activityの存在が" do
      it "あれば有効な状態であること" do
        expect(bmr).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bmr.activity = nil
        bmr.valid?
        expect(bmr.errors[:activity]).to include('を入力してください')
      end
    end
  end
end
