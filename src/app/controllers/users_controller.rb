class UsersController < ApplicationController
  
  def show
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
    
    
  end
  
  def calender
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
  end
end
