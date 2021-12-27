require 'rails_helper'

RSpec.describe Recipefood, type: :model do
  let(:recipefood) { FactoryBot.create(:recipefood) }
    
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        recipefood = Recipefood.reflect_on_association(:user)
        expect(recipefood.macro).to eq(:belongs_to)
      end
    end
    
    context "Recipeモデルとの関係" do
      it "N:1となっていること" do
        recipefood = Recipefood.reflect_on_association(:recipe)
        expect(recipefood.macro).to eq(:belongs_to)
      end
    end
    
    context "Myfoodモデルとの関係" do
      it "N:1となっていること" do
        recipefood = Recipefood.reflect_on_association(:myfood)
        expect(recipefood.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "レシピフードの登録" do
    context "分量の存在が" do
      it "あれば有効な状態であること" do
        expect(recipefood).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        recipefood.amount = nil
        recipefood.valid?
        expect(recipefood.errors[:amount]).to include('を入力してください')
      end
    end
    
    context '分量の値が' do
      it '1以上であれば有効であること' do
        recipefood.amount >= 1
        expect(recipefood).to be_valid
      end
  
      it '100以下であれば有効であること' do
        recipefood.amount <= 100
        expect(recipefood).to be_valid
      end
    end
    
  end
end
