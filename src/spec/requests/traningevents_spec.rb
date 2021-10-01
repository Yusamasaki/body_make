require 'rails_helper'

RSpec.describe "Traningevents", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/traningevents/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/traningevents/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/traningevents/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/traningevents/index"
      expect(response).to have_http_status(:success)
    end
  end

end
