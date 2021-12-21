require 'rails_helper'

RSpec.describe "ExerciseCategories", type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:exercise_category) { FactoryBot.create(:exercise_category) }
  let(:exercise_content) { FactoryBot.create(:exercise_content) }

  describe "GET index" do
    it "管理者でログイン時204httpレスポンスを返すこと" do
      sign_in admin
      get exercise_categories_path, xhr: true
      expect(response.status).to eq 204
    end

    it "管理者でログインしていない時401httpレスポンスを返すこと" do
      get exercise_categories_path, xhr: true
      expect(response.status).to eq 401
    end

    it "登録一般ユーザーがアクセスした時401httpレスポンスを返すこと" do
      get exercise_categories_path, xhr: true
      expect(response.status).to eq 401
    end
  end

  describe "GET new" do
    it "管理者でログイン時200レスポンスを返すこと" do
      sign_in admin
      get new_exercise_category_path, xhr: true
      expect(response.status).to eq 200
    end

    it "管理者でログインしていない時401httpレスポンスを返すこと" do
      get new_exercise_category_path, xhr: true
      expect(response.status).to eq 401
    end

    it "登録一般ユーザーがアクセスした時401httpレスポンスを返すこと" do
      get new_exercise_category_path, xhr: true
      expect(response.status).to eq 401
    end
  end

  describe "POST create" do
    it "カテゴリーが作成できること" do
      expect do
        category_params = FactoryBot.attributes_for(:exercise_category)
        sign_in admin

        expect {
          post exercise_categories_path, params: { exercise_category: category_params }
        }.to change(exercise_category, :count).by(1)
        pp exercise_category
      end
    end
  end
  
end
