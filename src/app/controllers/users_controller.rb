class UsersController < ApplicationController
  
  before_action :bodyweight_set_one_month, only: [:show]
  before_action :set_user, only: [:show]
  
  def show
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = current_user.bodyweights.all
    
    @bmr = @user.bmr
    
    @target_weight = @user.targetweight
    
    # グラフ用にgonでjs用の配列に変更
    gon.start_times = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:start_time)
    gon.body_weights = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time).pluck(:body_weight)
    
    # @latest = @user.bodyweights.order(:body_weight).limit(1).pluck(:body_weight)
    # @target_weights = [@target_weight.body_weight] + @latest
    # @s = ((@target_weight.body_weight - @target_weights.sum) / @target_weight.body_weight) * 100
    
  end
end
