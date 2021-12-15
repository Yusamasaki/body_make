require 'rails_helper'

RSpec.describe PfcRatio, type: :model do
  let(:pfc_ratio) { FactoryBot.create(:pfc_ratio) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        pfc_ratio = PfcRatio.reflect_on_association(:user)
        expect(pfc_ratio.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "PFC登録" do
    context "proteinの存在が" do
      it "あれば有効な状態であること" do
        expect(pfc_ratio).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        pfc_ratio.protein = nil
        pfc_ratio.valid?
        expect(pfc_ratio.errors[:protein]).to include('を入力してください')
      end
    end
    
    context "fatの存在が" do
      it "あれば有効な状態であること" do
        expect(pfc_ratio).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        pfc_ratio.fat = nil
        pfc_ratio.valid?
        expect(pfc_ratio.errors[:fat]).to include('を入力してください')
      end
    end
    
    context "carboの存在が" do
      it "あれば有効な状態であること" do
        expect(pfc_ratio).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        pfc_ratio.carbo = nil
        pfc_ratio.valid?
        expect(pfc_ratio.errors[:carbo]).to include('を入力してください')
      end
    end
    
  end
end
