class UsersController < ApplicationController
  
  def show
    @body_weight = current_user.bodyweights.find_by(id: params[:bodyweight_id])
    @body_weights = current_user.bodyweights.all
    
    # グラフ機能仮置き
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
    gon.day = one_month
  end
  
end
