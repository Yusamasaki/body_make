class UsersController < ApplicationController
  
  before_action :bodyweight_set_one_month, only: [:show]
  
  def show
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = current_user.bodyweights.all
    
    # グラフ用にgonでjs用の配列に変更
    gon.start_times = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:start_time)
    gon.body_weights = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:body_weight)
  end
end
