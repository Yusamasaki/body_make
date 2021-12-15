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
  
  describe "登録" do
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(todaymeal).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        todaymeal.start_time = nil
        todaymeal.valid?
        expect(todaymeal.errors[:start_time]).to include('を入力してください')
      end
    end
    
    context "分量" do
      it "あれば有効な状態であること" do
        expect(todaymeal).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        todaymeal.amount = nil
        todaymeal.valid?
        expect(todaymeal.errors[:amount]).to include('を入力してください')
      end
      
      it '1以上であれば有効であること' do
        todaymeal.amount >= 1
        expect(todaymeal).to be_valid
      end
      
      it '100以下であれば有効であること' do
        todaymeal.amount <= 100
        expect(todaymeal).to be_valid
      end
    end
    
    context "備考の文字数が" do
      it '100文字以内であれば有効な状態であること' do
        todaymeal.note = 'a' * 100
        expect(todaymeal).to be_valid
      end

      it '100文字以上であれば無効な状態であること' do
        todaymeal.note = 'a' * 101
        todaymeal.valid?
        expect(todaymeal.errors[:note]).to include('は100文字以内で入力してください')
      end
    end
  end
end
