require 'rails_helper'

RSpec.describe TraningAnalysis, type: :model do
  let(:traning_analysis) { FactoryBot.create(:traning_analysis) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        traning_analysis = TraningAnalysis.reflect_on_association(:user)
        expect(traning_analysis.macro).to eq(:belongs_to)
      end
    end
    context "Traningeventモデルとの関係" do
      it "N:1となっていること" do
        traning_analysis = TraningAnalysis.reflect_on_association(:traningevent)
        expect(traning_analysis.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(traning_analysis).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        traning_analysis.start_time = nil
        traning_analysis.valid?
        expect(traning_analysis.errors[:start_time]).to include('を入力してください')
      end
    end
  end
end
