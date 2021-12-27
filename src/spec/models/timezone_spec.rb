require 'rails_helper'

RSpec.describe Timezone, type: :model do
  let(:timezone) { FactoryBot.create(:timezone) }
  
  describe "時間帯の登録" do
    context "時間帯の存在が" do
      it "あれば有効な状態であること" do
        expect(timezone).to be_valid
      end
      
      it 'なければ無効な状態であること' do
        timezone.time_zone = nil
        timezone.valid?
        expect(timezone.errors[:time_zone]).to include('を入力してください')
      end
    end
  end
end
