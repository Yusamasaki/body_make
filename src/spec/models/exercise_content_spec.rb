require 'rails_helper'

RSpec.describe ExerciseContent, type: :model do
  let(:exercise_content) { FactoryBot.create(:exercise_content) }

  describe "アソシエーションテスト" do
    context "ExerciseCategoryモデルとの関係" do
      it "N:1となっていること" do
        exercise_content = ExerciseContent.reflect_on_association(:exercise_category)
        expect(exercise_content.macro).to eq(:belongs_to)
      end
    end
  end

  describe '運動コンテンツの登録' do
    context 'コンテンツ名の存在が' do
      it 'あれば有効な状態であること' do
        expect(exercise_content).to be_valid
      end

      it 'なければ無効な状態であること' do
        exercise_content.content = nil
        exercise_content.valid?
        expect(exercise_content.errors[:content]).to include('を入力してください')
      end
    end

    context 'コンテンツ名の文字数が' do
      it '20文字以内であれば有効な状態であること' do
        exercise_content.content = 'a' * 20
        expect(exercise_content).to be_valid
      end

      it '20文字以上であれば無効な状態であること' do
        exercise_content.content = 'a' * 21
        exercise_content.valid?
        expect(exercise_content.errors[:content]).to include('は20文字以内で入力してください')
      end
    end

    context 'metsの存在が' do
      it 'あれば有効な状態であること' do
        expect(exercise_content).to be_valid
      end

      it 'なければ無効な状態であること' do
        exercise_content.mets = nil
        exercise_content.valid?
        expect(exercise_content.errors[:mets]).to include('を入力してください')
      end
    end

    context 'metsの値が' do
      it '文字列型であれば無効な状態であること' do
        exercise_content.mets = 'string'
        exercise_content.valid?
        expect(exercise_content.errors[:mets]).to include('は数値で入力してください')
      end

      it '999以内であれば有効であること' do
        exercise_content.mets = 999.0
        expect(exercise_content).to be_valid
      end
  
      it '999以上であれば無効であること' do
        exercise_content.mets = 999.1
        exercise_content.valid?
        expect(exercise_content.errors[:mets]).to include('は999以下の値にしてください')  
      end
    end
  end
end
