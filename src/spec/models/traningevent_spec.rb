require 'rails_helper'

RSpec.describe Traningevent, type: :model do
  let(:traningevent) { FactoryBot.create(:traningevent) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        traningevent = Traningevent.reflect_on_association(:user)
        expect(traningevent.macro).to eq(:belongs_to)
      end
    end
  end
  
  describe "トレーニングイベントの登録" do
    it '重複したトレーニング名があれば無効な状態であること' do
      traningevent1 = FactoryBot.create(:traningevent)
      traningevent2 = FactoryBot.build(:traningevent, traning_name: traningevent1.traning_name)

      traningevent2.valid?
      expect(traningevent2.errors[:traning_name]).to include('はすでに存在します')
    end
    
    context "トレーニング名の存在が" do
      it "あれば有効な状態であること" do
        expect(traningevent).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        traningevent.traning_name = nil
        traningevent.valid?
        expect(traningevent.errors[:traning_name]).to include('を入力してください')
      end
    end
    
    context 'トレーニング名の文字数が' do
      it '50文字以内であれば有効な状態であること' do
        traningevent.traning_name = 'a' * 50
        expect(traningevent).to be_valid
      end

      it '50文字以上であれば無効な状態であること' do
        traningevent.traning_name = 'a' * 51
        traningevent.valid?
        expect(traningevent.errors[:traning_name]).to include('は50文字以内で入力してください')
      end
    end
  end
  
  describe "bodypart_idの登録" do
    context "bodypart_idの存在が" do
      it 'あれば有効な状態であること' do
        expect(traningevent).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        traningevent.bodypart_id = nil
        traningevent.valid?
        expect(traningevent.errors[:bodypart_id]).to include('を入力してください')
      end
    end
  end
end
