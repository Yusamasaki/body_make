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
end
