require 'rails_helper'

RSpec.describe Bodyweight, type: :model do
  let(:bodyweight) { FactoryBot.create(:bodyweight) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        bodyweight = Bodyweight.reflect_on_association(:user)
        expect(bodyweight.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "体重登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(bodyweight).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bodyweight.start_time = nil
        bodyweight.valid?
        expect(bodyweight.errors[:start_time]).to include('を入力してください')
      end
    end
  end
end
