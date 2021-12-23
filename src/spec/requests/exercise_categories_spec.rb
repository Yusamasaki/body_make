require 'rails_helper'

RSpec.describe "ExerciseCategories", type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:exercise_category) { FactoryBot.create(:exercise_category) }
  let(:category1) { FactoryBot.create(:category1) }
  let(:category2) { FactoryBot.create(:category2) }
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

    describe "PATCH update" do
      context "パラメータが妥当な場合" do
        it "リクエストが成功すること" do
          expect do
            sign_in admin
            patch exercise_category_path(category1), params: { exercise_category: FactoryBot.attributes_for(:category2) }
            expect(response.status).to eq 302
          end
        end

        it "カテゴリーが更新されること" do
          expect do
            sign_in admin
            patch exercise_category_path(category1), params: { exercise_category: FactoryBot.attributes_for(:category2) }
          end.to change { ExerciseCategory.find(category1.id).name }.from("カテゴリー1").to("カテゴリー2")
        end
      end

      context "パラメータが不正な場合" do
        it "リクエストが成功すること" do
          expect do
            sign_in admin
            patch exercise_category_path(category1), params: { exercise_category: FactoryBot.attributes_for(:exercise_category, :invalid) }
            expect(response.status).to eq 302
          end
        end

        it "カテゴリーが変更されないこと" do
          expect do
            sign_in admin
            expect(
              post exercise_categories_path, params: { exercise_category: FactoryBot.attributes_for(:exercise_category, :invalid) }
            ).to_not change(ExerciseCategory.find(category1.id), :name)
          end
        end
      end
    end

    describe "DELETE destroy" do
      it "リクエストが成功すること" do
        expect do
          sign_in admin
          delete exercise_category_path(category1), params: { id: exercise_category }
          expect(response.status).to eq 302
        end
      end

      it 'カテゴリーが削除されること' do
        expect do
          sign_in admin
          expect(
            delete exercise_category_path(category1), params: { id: exercise_category }
          ).to change(exercise_category, :count).by(-1)
        end
      end
    end
  end
end
