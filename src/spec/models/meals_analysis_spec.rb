require 'rails_helper'

RSpec.describe MealsAnalysis, type: :model do
  let(:meals_analysis) { FactoryBot.create(:meals_analysis) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        meals_analysis = MealsAnalysis.reflect_on_association(:user)
        expect(meals_analysis.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(meals_analysis).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        meals_analysis.start_time = nil
        meals_analysis.valid?
        expect(meals_analysis.errors[:start_time]).to include('を入力してください')
      end
    end
  end
end
