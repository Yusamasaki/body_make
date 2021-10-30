class MealsAnalysisController < ApplicationController
  
  before_action :set_user, only: [:index]
  before_action :set_basic, only: [:index]
  before_action :set_bmr, only: [:index]
  
  def index
    
  end
end
