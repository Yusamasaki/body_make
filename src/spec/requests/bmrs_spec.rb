require 'rails_helper'

RSpec.describe "Bmrs", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/bmrs/new"
      expect(response).to have_http_status(:success)
    end
  end

end