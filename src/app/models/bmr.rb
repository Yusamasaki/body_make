class Bmr < ApplicationRecord
  belongs_to :user

  validates :gender, presence: true
  validates :age, presence: true, length: { maximum: 3 }
  validates :height, presence: true, length: { maximum: 5 } 
  validates :activity, presence: true
  
  # 基礎代謝
  def self.bmr_format(gender, now_body_weight, newwest_body_weight, height, age)
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
  
  # 1日の消費カロリー
  def self.day_calorie(bmr_format, activity)
    bmr_format * activity.to_f
  end
  
  # 目標の摂取カロリー
  def self.day_target_calorie(day_calorie, target_weight)
    (day_calorie - ( 7000 * ( target_weight.now_body_weight - target_weight.goal_body_weight ) ) / ( target_weight.beginning_date.to_date.yday - target_weight.target_date.to_date.yday )).abs.floor(1)
  end
end
