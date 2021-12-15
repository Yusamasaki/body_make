require 'rails_helper'

RSpec.describe Todaymeal, type: :model do
  let(:todaymeal) { FactoryBot.create(:todaymeal) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        todaymeal = Todaymeal.reflect_on_association(:user)
        expect(todaymeal.macro).to eq(:belongs_to)
      end
    end
    
    context "Timezoneモデルとの関係" do
      it "N:1となっていること" do
        todaymeal = Todaymeal.reflect_on_association(:timezone)
        expect(todaymeal.macro).to eq(:belongs_to)
      end
    end
    
    context "Myfoodモデルとの関係" do
      it "N:1となっていること" do
        todaymeal = Todaymeal.reflect_on_association(:myfood)
        expect(todaymeal.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(todaymeal).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        todaymeal.start_time = nil
        todaymeal.valid?
        expect(todaymeal.errors[:start_time]).to include('を入力してください')
      end
    end
  end
end
