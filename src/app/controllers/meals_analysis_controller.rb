class MealsAnalysisController < ApplicationController
  
  # before_action :logged_in_user, only: :index
  before_action :set_user, only: [:index]
  before_action :set_basic, only: [:index]
  before_action :set_bmr, only: [:index]
  before_action :ser_meals_analysis, only: [:index]
  
  def index
    
  end
end
