require 'rails_helper'

RSpec.describe Myfood, type: :model do
  let(:myfood) { FactoryBot.create(:myfood) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        myfood = Myfood.reflect_on_association(:user)
        expect(myfood.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "食品の登録" do
    
    it '重複した食品名があれば無効な状態であること' do
      myfood1 = FactoryBot.create(:myfood)
      myfood2 = FactoryBot.build(:myfood, food_name: myfood1.food_name)

      myfood2.valid?
      expect(myfood2.errors[:food_name]).to include('はすでに存在します')
    end
    
    context "食品名の存在が" do
      it "あれば有効な状態であること" do
        expect(myfood).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        myfood.food_name = nil
        myfood.valid?
        expect(myfood.errors[:food_name]).to include('を入力してください')
      end
    end
    
    context '食品名の文字数が' do
      it '100文字以内であれば有効な状態であること' do
        myfood.food_name = 'a' * 100
        expect(myfood).to be_valid
      end

      it '100文字以上であれば無効な状態であること' do
        myfood.food_name = 'a' * 101
        myfood.valid?
        expect(myfood.errors[:food_name]).to include('は100文字以内で入力してください')
      end
    end
    
    context "proteinが" do
      it 'なければ無効な状態であること' do
        myfood.protein = nil
        myfood.valid?
        expect(myfood.errors[:protein]).to include('を入力してください')
      end
      it '1000以下であれば有効であること' do
        myfood.protein <= 1000
        expect(myfood).to be_valid
      end
    end
    
    context "fatが" do
      it 'なければ無効な状態であること' do
        myfood.protein = nil
        myfood.valid?
        expect(myfood.errors[:protein]).to include('を入力してください')
      end

      it '1000以下であれば有効であること' do
        myfood.protein <= 1000
        expect(myfood).to be_valid
      end
    end
    
    context "carboが" do
      it 'なければ無効な状態であること' do
        myfood.carbo = nil
        myfood.valid?
        expect(myfood.errors[:carbo]).to include('を入力してください')
      end

      it '1000以下であれば有効であること' do
        myfood.carbo <= 1000
        expect(myfood).to be_valid
      end
    end
    
    context "sugarが" do
      it 'なければ無効な状態であること' do
        myfood.sugar = nil
        myfood.valid?
        expect(myfood.errors[:sugar]).to include('を入力してください')
      end

      it '1000以下であれば有効であること' do
        myfood.sugar <= 1000
        expect(myfood).to be_valid
      end
    end
    
    context "dietary_fiberが" do
      it 'なければ無効な状態であること' do
        myfood.dietary_fiber = nil
        myfood.valid?
        expect(myfood.errors[:dietary_fiber]).to include('を入力してください')
      end

      it '1000以下であれば有効であること' do
        myfood.dietary_fiber <= 1000
        expect(myfood).to be_valid
      end
    end
    
    context "saltが" do
      it 'なければ無効な状態であること' do
        myfood.salt = nil
        myfood.valid?
        expect(myfood.errors[:salt]).to include('を入力してください')
      end

      it '1000以下であれば有効であること' do
        myfood.salt <= 1000
        expect(myfood).to be_valid
      end
    end
  end
end
