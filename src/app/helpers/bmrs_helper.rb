module BmrsHelper
  
  # 活動レベル
  def activity_select
    {
      "ほぼ運動しない。通勤・デスクワーク程度": 1.2,
      "軽い運動。週に1～2回程度の運動": 1.375,
      "中程度の運動。週に3～5回程度の運動": 1.55,
      "激しい運動。週に6～7回程度の運動": 1.725,
      "非常に激しい運動。一日に2回程度の運動": 1.9
    }
  end
  
  # 基礎代謝計算
  def bmr_format(gender, now_body_weight, newwest_body_weight, height, age)
    if newwest_body_weight == 0 && gender == "男性"
      ( ( now_body_weight * 13.397 ) + ( height * 4.799 ) - ( age * 5.677 ) + 88.362 )
    elsif newwest_body_weight == 0 && gender == "女性"
      ( ( now_body_weight * 9.247 ) + ( height * 3.098 ) - ( age * 4.33 ) + 447.593 )
    elsif  newwest_body_weight.present? && gender == "男性"
      ( ( newwest_body_weight * 13.397 ) + ( height * 4.799 ) - ( age * 5.677 ) + 88.362 )
    elsif
      ( ( newwest_body_weight * 9.247 ) + ( height * 3.098 ) - ( age * 4.33 ) + 447.593 )
    end
  end

  # 基礎代謝計算 * 運動量
  def bmr_format_activty(bmr_format, activity)
    bmr_format * activity.to_f
  end

  # 1日の可能摂取カロリー
  def one_day_decrease(bmr_format, target_weight)
    (bmr_format - ( 7000 * ( target_weight.now_body_weight - target_weight.goal_body_weight ) ) / ( target_weight.beginning_date.to_date.yday - target_weight.target_date.to_date.yday )).abs.floor(1)
  end

   # 1日のPFCバランス
  def pfc_format(one_day_decrease, ratio, per_1g)
    ( ( ( one_day_decrease * ratio ) / 100 ) / per_1g ).floor(1)
  end

end
