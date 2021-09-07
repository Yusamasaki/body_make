class UsersController < ApplicationController
  
  before_action :bodyweight_set_one_month, only: [:show]
  before_action :set_user, only: [:show]
  
  def show
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = current_user.bodyweights.all
    
    @bmr = @user.bmr
    
    @target_weight = @user.targetweight
    gon.target_weight = @target_weight
    
    # グラフ用にgonでjs用の配列に変更
    gon.start_times = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:start_time)
    gon.body_weights = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:body_weight)
    
    # ドーナツグラフData
    # 最新の体重
    @bodyweight_latest = @user.bodyweights.order(:body_weight).limit(1).pluck(:body_weight)
    
    @target_weight_pull_bodyweight_latest = [@bodyweight_latest.sum - @target_weight.body_weight]
    # 最新の体重, 目標
    gon.bodyweight_latest_target = @bodyweight_latest + @target_weight_pull_bodyweight_latest
    # 体重の達成率
    @bodyweight_achievement_rate = @target_weight.body_weight.to_f / @bodyweight_latest.sum.to_f * 100

  end
end
