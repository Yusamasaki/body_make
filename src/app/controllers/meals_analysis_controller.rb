class MealsAnalysisController < ApplicationController
  
  before_action :set_user, only: [:index]
  before_action :set_basic, only: [:index]
  before_action :set_bmr, only: [:index]
  
  def index
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
      
      @meals_analysis = @user.meals_analysis.where( start_time: @first_day..@last_day).order(:start_time)
      gon.start_times = @meals_analysis.pluck(:start_time).map{|day| day.day}
      gon.calories = @meals_analysis.pluck(:calorie)
      gon.day_target_calorie = @day_target_calorie
      
      unless one_month.count <= @meals_analysis.count
        ActiveRecord::Base.transaction do
          one_month.each { |day| @user.meals_analysis.create!(start_time: day) }
        end
        @meals_analysis = @user.meals_analysis.where(start_time: @first_day..@last_day).order(:start_time)
      end
  end
end
