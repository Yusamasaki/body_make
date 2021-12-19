require 'rails_helper'

RSpec.describe Targetweight, type: :model do
  let(:targetweight) { FactoryBot.create(:targetweight) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        targetweight = PfcRatio.reflect_on_association(:user)
        expect(targetweight.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe '目標の登録' do
    context '現在の体重の存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.now_body_weight = nil
        targetweight.valid?
        expect(targetweight.errors[:now_body_weight]).to include('を入力してください')
      end
    end
    context '目標の体重の存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.goal_body_weight = nil
        targetweight.valid?
        expect(targetweight.errors[:goal_body_weight]).to include('を入力してください')
      end
    end
    context '現在の体脂肪率の存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.now_bodyfat_percentage = nil
        targetweight.valid?
        expect(targetweight.errors[:now_bodyfat_percentage]).to include('を入力してください')
      end
    end
    context '目標の体脂肪率の存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.goal_bodyfat_percentage = nil
        targetweight.valid?
        expect(targetweight.errors[:goal_bodyfat_percentage]).to include('を入力してください')
      end
    end
    context '目標の体脂肪率の存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.goal_bodyfat_percentage = nil
        targetweight.valid?
        expect(targetweight.errors[:goal_bodyfat_percentage]).to include('を入力してください')
      end
    end
    context '現在の日にちの存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.beginning_date = nil
        targetweight.valid?
        expect(targetweight.errors[:beginning_date]).to include('を入力してください')
      end
    end
    context '目標の日にちの存在が' do
      it 'あれば有効な状態であること' do
        expect(targetweight).to be_valid
      end
      it 'なければ無効な状態であること' do
        targetweight.target_date = nil
        targetweight.valid?
        expect(targetweight.errors[:target_date]).to include('を入力してください')
      end
    end
  end
end
