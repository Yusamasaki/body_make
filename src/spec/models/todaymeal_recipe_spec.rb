require 'rails_helper'

RSpec.describe TodaymealRecipe, type: :model do
  let(:todaymeal_recipe) { FactoryBot.create(:todaymeal_recipe) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        todaymeal_recipe = TodaymealRecipe.reflect_on_association(:user)
        expect(todaymeal_recipe.macro).to eq(:belongs_to)
      end
    end
    
    context "Timezoneモデルとの関係" do
      it "N:1となっていること" do
        todaymeal_recipe = TodaymealRecipe.reflect_on_association(:timezone)
        expect(todaymeal_recipe.macro).to eq(:belongs_to)
      end
    end
    
    context "Recipeモデルとの関係" do
      it "N:1となっていること" do
        todaymeal_recipe = TodaymealRecipe.reflect_on_association(:recipe)
        expect(todaymeal_recipe.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(todaymeal_recipe).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        todaymeal_recipe.start_time = nil
        todaymeal_recipe.valid?
        expect(todaymeal_recipe.errors[:start_time]).to include('を入力してください')
      end
    end
  end
end
