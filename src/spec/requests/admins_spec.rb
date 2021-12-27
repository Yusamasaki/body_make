require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET show ログインする" do
    let(:admin) { FactoryBot.create(:admin) }

    context "管理者ログイン成功時" do
      it "200httpレスポンスを返すこと" do
        sign_in admin
        get admin_path(admin)
        expect(response.status).to eq 200
      end
    end

    context "管理者ログインしない(失敗)時" do
      it "302httpレスポンスを返すこと" do
        get admin_path(admin)
        expect(response.status).to eq 302  
      end
    end
  end

end
