require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { FactoryBot.create(:recipe) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        recipe = Recipe.reflect_on_association(:user)
        expect(recipe.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "レシピの登録" do
    
    it '重複したレシピ名があれば無効な状態であること' do
      recipe1 = FactoryBot.create(:recipe)
      recipe2 = FactoryBot.build(:recipe, recipe_name: recipe1.recipe_name)

      recipe2.valid?
      expect(recipe2.errors[:recipe_name]).to include('はすでに存在します')
    end
    
    context "レシピ名の存在が" do
      it "あれば有効な状態であること" do
        expect(recipe).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        recipe.recipe_name = nil
        recipe.valid?
        expect(recipe.errors[:recipe_name]).to include('を入力してください')
      end
    end
    
    context 'レシピ名の文字数が' do
      it '100文字以内であれば有効な状態であること' do
        recipe.recipe_name = 'a' * 100
        expect(recipe).to be_valid
      end

      it '100文字以上であれば無効な状態であること' do
        recipe.recipe_name = 'a' * 101
        recipe.valid?
        expect(recipe.errors[:recipe_name]).to include('は100文字以内で入力してください')
      end
    end
  end
end
