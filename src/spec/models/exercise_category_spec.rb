require 'rails_helper'

RSpec.describe ExerciseCategory, type: :model do
  let(:exercise_category) { FactoryBot.build(:exercise_category) }

  describe '運動カテゴリーを登録する' do

    it '重複したカテゴリー名があれば無効な状態であること' do
      category1 = FactoryBot.create(:exercise_category)
      category2 = FactoryBot.build(:exercise_category, name: category1.name)

      category2.valid?
      expect(category2.errors[:name]).to include('はすでに存在します')
    end

    context 'カテゴリー名の存在が' do
      it 'あれば有効な状態であること' do
        expect(exercise_category).to be_valid
      end

      it 'なければ無効な状態であること' do
        exercise_category.name = nil
        exercise_category.valid?
        expect(exercise_category.errors[:name]).to include('を入力してください')
      end
    end

    context 'カテゴリー名の文字数が' do
      it '15文字以内であれば有効であること' do
        category = FactoryBot.build(:exercise_category, name: 'a' * 15)
        expect(exercise_category).to be_valid
      end

      it '15文字以上であれば無効であること' do
        category = FactoryBot.build(:exercise_category, name: 'a' * 16)
        category.valid?
        expect(category.errors[:name]).to include('は15文字以内で入力してください')
      end
    end

  end
end
