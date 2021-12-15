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
end
