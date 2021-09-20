require 'rails_helper'

RSpec.describe "PfcRatios", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/pfc_ratio/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/pfc_ratio/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
