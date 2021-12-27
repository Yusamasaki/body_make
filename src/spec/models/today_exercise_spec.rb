require 'rails_helper'

RSpec.describe TodayExercise, type: :model do
  let(:today_exercise) { FactoryBot.create(:today_exercise) }
  
  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1となっていること" do
        today_exercise = TodayExercise.reflect_on_association(:user)
        expect(today_exercise.macro).to eq(:belongs_to)
      end
    end
  end

  describe 'today_exerciseの登録' do
    context "start_time, exercise_time_hour, exercise_time_min, body_weightのうち" do
      it '全ての存在があれば有効であること' do
        expect(today_exercise).to be_valid
      end

      it 'start_timeの存在が無ければ無効であること' do
        today_exercise.start_time = nil
        today_exercise.valid?
        expect(today_exercise.errors[:start_time]).to include('を入力してください')
      end

      it 'exercise_time_hourの存在が無ければ無効であること' do
        today_exercise.exercise_time_hour = nil
        today_exercise.valid?
        expect(today_exercise.errors[:exercise_time_hour]).to include('を入力してください')
      end

      it 'exercise_time_minの存在が無ければ無効であること' do
        today_exercise.exercise_time_min = nil
        today_exercise.valid?
        expect(today_exercise.errors[:exercise_time_min]).to include('を入力してください')
      end

      it '体重の存在が無ければ無効であること' do
        today_exercise.body_weight = nil
        today_exercise.valid?
        expect(today_exercise.errors[:body_weight]).to include('を入力してください')
      end
    end

    context "exercise_time_hourの値が" do
      it '23以内であれば有効であること' do
        today_exercise.exercise_time_hour = 23
        expect(today_exercise).to be_valid
      end

      it '24以上であれば無効であること' do
        today_exercise.exercise_time_hour = 24
        today_exercise.valid?
        expect(today_exercise.errors[:exercise_time_hour]).to include('は24より小さい値にしてください')
      end
    end

    context "exercise_time_minの値が" do
      it '59以内であれば有効であること' do
        today_exercise.exercise_time_min = 59
        expect(today_exercise).to be_valid
      end

      it '60以上であれば無効であること' do
        today_exercise.exercise_time_min = 60
        today_exercise.valid?
        expect(today_exercise.errors[:exercise_time_min]).to include('は60より小さい値にしてください')
      end
    end

    context "備考の文字数が" do
      it '30文字以内であれば有効であること' do
        today_exercise.note = 'a' * 30
        expect(today_exercise).to be_valid
      end

      it '31文字以上であれば有効であること' do
        today_exercise.note = 'a' * 31
        today_exercise.valid?
        expect(today_exercise.errors[:note]).to include('は30文字以内で入力してください')
      end
    end
  end
end
