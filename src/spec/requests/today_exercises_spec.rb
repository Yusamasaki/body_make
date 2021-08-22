require 'rails_helper'

RSpec.describe "TodayExercises", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/today_exercises/new"
      expect(response).to have_http_status(:success)
    end
  end

end
