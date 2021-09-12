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
    
# --------- doughnut_graphのData ---------

  # --------- 体重計算 ---------
  
    # 最新の体重
    @newwest_bodyweight = @user.bodyweights.order(:body_weight).limit(1).pluck(:body_weight)
    
    # 落とす体重
    @now_body_weight_pull_goal_body_weight =  if @newwest_bodyweight == [nil]
                                                @target_weight.now_body_weight - @target_weight.goal_body_weight
                                              else
                                                (@target_weight.now_body_weight - @target_weight.goal_body_weight) - (@target_weight.now_body_weight - @newwest_bodyweight.sum)
                                              end
                                              
    # 体重の進捗
    @progress_bodyweight =  if @newwest_bodyweight == [nil]
                              0
                            else
                                @target_weight.now_body_weight - @newwest_bodyweight.sum
                            end
    
    # gonでグラフデータ化
    gon.body_weight_area = [@progress_bodyweight.abs] +  [@now_body_weight_pull_goal_body_weight.abs]
    
    # 体重の達成率
    @bodyweight_achievement_rate = (@progress_bodyweight.to_f / (@target_weight.now_body_weight.to_f - @target_weight.goal_body_weight.to_f)) * 100
    

  # --------- 体脂肪率計算 ---------
    
    # 最新の体脂肪率
    @newwest_bodyfat_percentage = @user.bodyweights.order(:bodyfat_percentage).limit(1).pluck(:bodyfat_percentage)
    
    @bodyweights.each{|day|}
    
    
    # 落とす体脂肪率
    gon.now_bodyfat_percentage_pull_goal_bodyfat_percentage = @target_weight.now_bodyfat_percentage - @target_weight.goal_bodyfat_percentage
    
    # 体脂肪率の進捗
    gon.progress_bodyfat_percentage = if @newwest_bodyfat_percentage == [nil]
                                        0
                                      else
                                        @target_weight.now_bodyfat_percentage - @newwest_bodyfat_percentage.sum
                                      end
  end
end
