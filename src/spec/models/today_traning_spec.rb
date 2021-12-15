require 'rails_helper'

RSpec.describe TodayTraning, type: :model do
  let(:today_traning) { FactoryBot.create(:today_traning) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        today_traning = TodayTraning.reflect_on_association(:user)
        expect(today_traning.macro).to eq(:belongs_to)
      end
    end
    
    context "Traningeventモデルとの関係" do
      it "N:1となっていること" do
        today_traning = TodayTraning.reflect_on_association(:traningevent)
        expect(today_traning.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "TodayTraningの登録" do
    
    context "日付の存在が" do
      it "あれば有効な状態であること" do
        expect(today_traning).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        today_traning.start_time = nil
        today_traning.valid?
        expect(today_traning.errors[:start_time]).to include('を入力してください')
      end
    end
    
    context "traning_weight(重量)の存在が" do
      it "あれば有効な状態であること" do
        expect(today_traning).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        today_traning.traning_weight = nil
        today_traning.valid?
        expect(today_traning.errors[:traning_weight]).to include('を入力してください')
      end
      
      it '1以上であれば有効であること' do
        today_traning.traning_weight >= 1
      end
      
      it '1000以下であれば有効であること' do
        today_traning.traning_weight <= 1000
      end
    end
    
    context "traning_reps(回数)の存在が" do
      it "あれば有効な状態であること" do
        expect(today_traning).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        today_traning.traning_reps = nil
        today_traning.valid?
        expect(today_traning.errors[:traning_reps]).to include('を入力してください')
      end
      
      it '1以上であれば有効であること' do
        today_traning.traning_weight >= 1
      end
      
      it '100以下であれば有効であること' do
        today_traning.traning_weight <= 100
      end
    end
    
    context 'traning_note(備考)の文字数が' do
      it '100文字以内であれば有効な状態であること' do
        today_traning.traning_note = 'a' * 100
        expect(today_traning).to be_valid
      end

      it '100文字以上であれば無効な状態であること' do
        today_traning.traning_note = 'a' * 101
        today_traning.valid?
        expect(today_traning.errors[:traning_note]).to include('は100文字以内で入力してください')
      end
    end
  end
end
