require 'rails_helper'

RSpec.describe ExerciseContent, type: :model do
  let(:exercise_content) { FactoryBot.create(:exercise_content) }

  describe '運動コンテンツを登録する' do

    context 'コンテンツ名の存在が' do
      it 'あれば有効な状態であること' do
        expect(exercise_content).to be_valid
      end

      it 'なければ無効な状態であること' do
        exercise_content.content = nil
        exercise_content.valid?
        expect(exercise_content.errors[:content]).to include('を入力してください')
        pp exercise_content
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

  end
end
