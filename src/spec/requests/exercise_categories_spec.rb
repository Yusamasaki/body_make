require 'rails_helper'

RSpec.describe "ExerciseCategories", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/exercise_categories/new"
      expect(response).to have_http_status(:success)
    end
  end

end
