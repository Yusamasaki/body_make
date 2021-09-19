module BodyweightsHelper
  
  # 体重の進捗率
  def bodyweight_achievement_rate(progress_bodyweight, target_weight)
    ((progress_bodyweight.to_f / (target_weight.now_body_weight.to_f - target_weight.goal_body_weight.to_f)) * 100).floor(1).abs
  end

  # 体脂肪率の進捗率
  def bodyfat_percentage_achievement_rate(progress_bodyfat_percentage, target_weight)
    ((progress_bodyfat_percentage.to_f / (target_weight.now_bodyfat_percentage.to_f - target_weight.goal_bodyfat_percentage.to_f)) * 100).floor(1).abs
  end

  # 後何日か
  def how_many_days_later(target_weight, starttime)
    target_weight.target_date.yday - starttime.to_date.yday
  end

  # 予想体重減量 1day/kg ((現在の体重-目標の体重)/(目標日-最新の体重記録日))
  def predict_bodyweight(target_weight, start_time)
    if target_weight.updated_at.to_date == start_time.to_date
      target_weight.now_body_weight
    elsif target_weight.updated_at.to_date > start_time.to_date
      target_weight.now_body_weight
    else
      BigDecimal(target_weight.now_body_weight -
      ((BigDecimal(target_weight.now_body_weight - target_weight.goal_body_weight) / 
        BigDecimal(target_weight.target_date.yday - target_weight.beginning_date.yday)) *
        BigDecimal(target_weight.beginning_date.yday - start_time.to_date.yday).abs)).abs.floor(1)
    end
  end

  def predict_bodyfat_percentage(target_weight, start_time)
    if target_weight.updated_at.to_date == start_time.to_date
      target_weight.now_bodyfat_percentage
    elsif target_weight.updated_at.to_date > start_time.to_date
      target_weight.now_bodyfat_percentage
    else
      BigDecimal(target_weight.now_bodyfat_percentage -
      ((BigDecimal(target_weight.now_bodyfat_percentage - target_weight.goal_bodyfat_percentage) / 
        BigDecimal(target_weight.target_date.yday - target_weight.beginning_date.yday)) *
        BigDecimal(target_weight.beginning_date.yday - start_time.to_date.yday).abs)).abs.floor(1)
    end
  end
  
end
