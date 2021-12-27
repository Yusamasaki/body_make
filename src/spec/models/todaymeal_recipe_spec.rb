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
    
    context "分量" do
      it "あれば有効な状態であること" do
        expect(todaymeal_recipe).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        todaymeal_recipe.amount = nil
        todaymeal_recipe.valid?
        expect(todaymeal_recipe.errors[:amount]).to include('を入力してください')
      end
      
      it '1以上であれば有効であること' do
        todaymeal_recipe.amount >= 1
        expect(todaymeal_recipe).to be_valid
      end
      
      it '100以下であれば有効であること' do
        todaymeal_recipe.amount <= 100
        expect(todaymeal_recipe).to be_valid
      end
    end
    
    context "備考の文字数が" do
      it '100文字以内であれば有効な状態であること' do
        todaymeal_recipe.note = 'a' * 100
        expect(todaymeal_recipe).to be_valid
      end

      it '100文字以上であれば無効な状態であること' do
        todaymeal_recipe.note = 'a' * 101
        todaymeal_recipe.valid?
        expect(todaymeal_recipe.errors[:note]).to include('は100文字以内で入力してください')
      end
    end
  end
end
