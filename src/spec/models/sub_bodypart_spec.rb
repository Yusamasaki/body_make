require 'rails_helper'

RSpec.describe SubBodypart, type: :model do
  let(:sub_bodypart) { FactoryBot.create(:sub_bodypart) }
  
  describe "アソシエーションテスト" do
    context "Bodypartモデルとの関係" do
      it "N:1となっていること" do
        sub_bodypart = SubBodypart.reflect_on_association(:bodypart)
        expect(sub_bodypart.macro).to eq(:belongs_to)
      end
    end
  end
end
