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
  def bmr_format(gender, now_body_weight, newwest_body_weight, height, age, activity)
    if newwest_body_weight == 0 && gender == "男性"
      ((now_body_weight * 13.397) + (height * 4.799) - (age * 5.677) + 88.362) * activity.to_f
    elsif newwest_body_weight == 0 && gender == "女性"
      ((now_body_weight * 9.247) + (height * 3.098) - (age * 4.33) + 447.593) * activity.to_f
    elsif  newwest_body_weight.present? && gender == "男性"
      ((newwest_body_weight * 13.397) + (height * 4.799) - (age * 5.677) + 88.362) * activity.to_f
    elsif
      ((newwest_body_weight * 9.247) + (height * 3.098) - (age * 4.33) + 447.593) * activity.to_f
    end
  end
end
