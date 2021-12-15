require 'rails_helper'

RSpec.describe Bodypart, type: :model do
  let(:bodypart) { FactoryBot.create(:bodypart) }
  
  describe "部位の登録" do
    context "部位の存在が" do
      it "あれば有効な状態であること" do
        expect(bodypart).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        bodypart.body_part = nil
        bodypart.valid?
        expect(bodypart.errors[:body_part]).to include('を入力してください')
      end
    end
  end
end
