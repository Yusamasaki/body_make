require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
  
  describe 'GET new ログイン' do
    before do
      sign_in(@user)
    end
    # 基本設定画面にアクセスした際に200レスポンス(アクセス成功)できることを検証
    it "200httpレスポンスを返す" do
      get new_user_bmr_path(@user.id)
      expect(response.status).to eq 200
    end
    # 基本設定画面にアクセスした際にnewページが表示されていることを確認
    it "newページが表示される" do
      get new_user_bmr_path(@user.id)
      expect(response).to render_template :new
    end
  end

  describe 'GET new ログインしていない' do
    # ログインしていないときに基本設定画面にアクセスした際にリダイレクト(302レスポンス)されることを検証
    it "302httpレスポンスを返す" do
      get new_user_bmr_path(@user.id)
      expect(response.status).to eq 302
    end
    # その際にログインページにリダイレクトされることを検証
    it "session/newページが表示される" do
      get new_user_bmr_path(@user.id)
      expect(response).to redirect_to root_path
    end
  end

  describe 'ログインページにアクセス　ログイン' do
    before do
      sign_in(@user)
    end
    # ログインしている際にログインページへアクセスした際にリダイレクト(302レスポンス)されることを検証
    it "302httpレスポンスを返す" do
      get new_user_session_path
      expect(response.status).to eq 302
    end
    # その際に基本設定ページにリダイレクトされることを検証
    it "newページが表示される" do
      get new_user_session_path
      expect(response).to redirect_to user_path(@user, switching: "bodyweight", start_date: Date.current.beginning_of_month, start_time: Date.current)
    end
  end
end