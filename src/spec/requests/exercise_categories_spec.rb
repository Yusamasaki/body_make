require 'rails_helper'

RSpec.describe "ExerciseCategories", type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:exercise_category) { FactoryBot.create(:exercise_category) }
  # let(:exercise_content) { FactoryBot.create(:exercise_content) }

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
    category_params = FactoryBot.attributes_for(:exercise_category)

    context "パラメータが妥当な場合" do
      it "リクエストが成功すること" do
        sign_in admin
        post exercise_categories_path, params: { exercise_category: category_params }
        expect(response.status).to eq 302
      end

      it "カテゴリーが登録できること" do
        expect do
          sign_in admin
          expect {
            post exercise_categories_path, params: { exercise_category: category_params }
          }.to change(exercise_category, :count).by(1)
        end
      end

      it "リダイレクトすること" do
        sign_in admin
        post exercise_categories_path, params: { exercise_category: category_params }
        expect(response).to redirect_to admin_path(admin)
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        sign_in admin
        post exercise_categories_path, params: { exercise_category: FactoryBot.attributes_for(:exercise_category, :invalid) }
        expect(response.status).to eq 302
      end

      it "カテゴリーが登録されないこと" do
        expect do
          sign_in admin
          expect(
            post exercise_categories_path, params: { exercise_category: FactoryBot.attributes_for(:exercise_category, :invalid) }
          ).to_not change(exercise_category, :count)
        end
      end
    end

    describe "GET edit" do
      it "リクエストが成功すること" do
        expect do
          sign_in admin
          get edit_exercise_category_path exercise_category, xhr: true
          expect(response.status).to eq 200
        end
      end

      it "値が取得できていること" do
        expect do
          sign_in admin
          get edit_exercise_category_path, params: { exercise_category: category_params }
          expect(assigns :exercise_category).to eq category_params
        end
      end
    end
    
  end
  
end
