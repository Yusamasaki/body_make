class BodyweightCalculationController < ActionController::Base

  # before_action :logged_in_user, only: :body_weight_caluculation

  def body_weight_caluculation
    # 選択している日の1週間前
        @week_before = params[:start_time].to_date.ago(7.days)
    
        # week_beforeの2週間後
        @after_week = @week_before.since(14.days)
      
        # 最新の体重
        @newwest_bodyweight = Bodyweight.newwest_bodyweight_get(@user)
    
        # 最新の体重の記録日
        @newwest_bodyweight_starttime = Bodyweight.newwest_bodyweight_starttime(@user, @newwest_bodyweight, @target_weight)
    
        # 落とす体重
        @now_body_weight_pull_goal_body_weight = Bodyweight.now_body_weight_pull_goal_body_weight(@newwest_bodyweight, @target_weight) 
                                                  
        # 体重の進捗
        @progress_bodyweight = Bodyweight.progress_bodyweight(@newwest_bodyweight, @target_weight) 
        
        # -------- gonでcheat.jsに変数定義 --------
                   
        # 目標体重       
        gon.goal_body_weight = @target_weight.goal_body_weight
        
        # @week_before　〜　@after_week　までの日付を配列表示してLine-chart化
        gon.start_times = Bodyweight.start_times(@user, @week_before, @after_week)
    
        # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
        gon.body_weights = Bodyweight.body_weights(@user, @week_before, @after_week)
    
        # 体重グラフX軸上限値
        gon.newwest_bodyweight_high_with = (@newwest_bodyweight.sum + 20).floor
    
        # 体重グラフX軸下限値
        gon.newwest_bodyweight_low_with = (@newwest_bodyweight.sum - 20).floor  
        
        # gonで体重グラフデータ化
        gon.body_weight_area = [@progress_bodyweight.floor(1).abs] + [@now_body_weight_pull_goal_body_weight.floor(1).abs]
    
    
      # --------- 体脂肪率計算 ---------
      
        # 最新の体脂肪率
        @newwest_bodyfat_percentage = Bodyweight.newwest_bodyfat_percentage(@user)
    
        # 最新の体脂肪率の記録日
        @newwest_bodyfat_percentage_starttime = Bodyweight.newwest_bodyfat_percentage_starttime(@user, @newwest_bodyfat_percentage, @target_weight)
                                        
        # 落とす体脂肪率
        @now_bodyfat_percentage_pull_goal_bodyfat_percentage = Bodyweight.now_bodyfat_percentage_pull_goal_bodyfat_percentage(@newwest_bodyfat_percentage, @target_weight)
                                                  
                                                  
        # 体脂肪率の進捗
        @progress_bodyfat_percentage = Bodyweight.progress_bodyfat_percentage(@newwest_bodyfat_percentage, @target_weight) 
                                
        # 目標の体脂肪率
        gon.goal_bodyfat_percentage = @target_weight.goal_bodyfat_percentage
        
    
        # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
        gon.bodyfat_percentages = Bodyweight.bodyfat_percentages(@user, @week_before, @after_week)
    
        # 体重グラフX軸上限値
        gon.newwest_bodyfat_percentage_high_with = (@newwest_bodyfat_percentage.sum + 20).floor
    
        # 体重グラフX軸下限値
        gon.newwest_bodyfat_percentage_low_with = (@newwest_bodyfat_percentage.sum - 20).floor  
        
        # gonで体重グラフデータ化
        gon.bodyfat_percentage_area = [@progress_bodyfat_percentage.floor(1).abs] + [@now_bodyfat_percentage_pull_goal_bodyfat_percentage.floor(1).abs]
      
  end