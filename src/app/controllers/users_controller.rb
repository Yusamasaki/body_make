class UsersController < ApplicationController
  
  before_action :bodyweight_set_one_month, only: [:show]
  before_action :set_user, only: [:show]
  
  def show
    
    @body_weight = @user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = @user.bodyweights.all
    
    @bmr = @user.bmr
    @target_weight = @user.targetweight

# --------- graphのDataなど ---------

  # --------- 体重計算 ---------
    
    # 選択している日の1週間前
    @week_before = params[:start_time].to_date.ago(7.days)

    # week_beforeの2週間後
    @after_week = @week_before.since(14.days)
  
    # 最新の体重
    @newwest_bodyweight = @user.bodyweights.order(:body_weight).limit(1).pluck(:body_weight)

    # 最新の体重の記録日
    @newwest_bodyweight_starttime = if @newwest_bodyweight == [nil]
                                      @target_weight.updated_at
                                    else
                                      @user.bodyweights.order(:body_weight).limit(1).pluck(:start_time).sum
                                    end

    # 落とす体重
    @now_body_weight_pull_goal_body_weight =  if @newwest_bodyweight == [nil]
                                                @target_weight.now_body_weight - @target_weight.goal_body_weight
                                              else
                                                (@target_weight.now_body_weight - @newwest_bodyweight.sum) - (@target_weight.now_body_weight - @target_weight.goal_body_weight)
                                              end
                                              
    # 体重の進捗
    @progress_bodyweight =  if @newwest_bodyweight == [nil]
                              0
                            else
                                @target_weight.now_body_weight - @newwest_bodyweight.sum
                            end
                            
                            
    gon.goal_body_weight = @target_weight.goal_body_weight
    
    # @week_before　〜　@after_week　までの日付を配列表示してLine-chart化
    gon.start_times = current_user.bodyweights.where( start_time: @week_before..@after_week).order(:start_time).pluck(:start_time)

    # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
    gon.body_weights = current_user.bodyweights.where( start_time: @week_before..@after_week).order(:start_time).pluck(:body_weight)

    # 体重グラフX軸上限値
    gon.newwest_bodyweight_high_with = (@newwest_bodyweight.sum + 20).floor

    # 体重グラフX軸下限値
    gon.newwest_bodyweight_low_with = (@newwest_bodyweight.sum - 20).floor  
    
    # gonで体重グラフデータ化
    gon.body_weight_area = [@progress_bodyweight.floor(1).abs] + [@now_body_weight_pull_goal_body_weight.floor(1).abs]


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
