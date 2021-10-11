class Bodyweight < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  
  # 体重が存在しない場合体脂肪率は無効、どちらも存在しない場合無効。
  validate :body_weight_is_invalid_without_a_bodyfat_percentage, on: :update
  
  def body_weight_is_invalid_without_a_bodyfat_percentage
    if body_weight.blank? && bodyfat_percentage.present? || body_weight.blank? && bodyfat_percentage.blank?
      errors.add(:body_weight, "が必要です") if body_weight.blank? && bodyfat_percentage.present? || body_weight.blank? && bodyfat_percentage.blank?
    end
  end
  
  # -------- 体重 --------
  
  # 最新の体重
  def self.newwest_bodyweight_get(user)
    user.bodyweights.order(:body_weight).limit(1).pluck(:body_weight)
  end
  
  # 最新の体重の記録日
  def self.newwest_bodyweight_starttime(user, newwest_bodyweight, target_weight)
    if newwest_bodyweight == [nil]
      target_weight.updated_at
    else
      user.bodyweights.order(:body_weight).limit(1).pluck(:start_time).sum
    end
  end
  
  # 落とす体重
  def self.now_body_weight_pull_goal_body_weight(newwest_bodyweight, target_weight)
    if newwest_bodyweight == [nil]
      target_weight.now_body_weight - target_weight.goal_body_weight
    else
      (target_weight.now_body_weight - newwest_bodyweight.sum) - (target_weight.now_body_weight - target_weight.goal_body_weight)
    end
  end
  
  # 体重の進捗
  def self.progress_bodyweight(newwest_bodyweight, target_weight)
    if newwest_bodyweight == [nil]
      0
    else
      target_weight.now_body_weight - newwest_bodyweight.sum
    end
  end
  
  # @week_before　〜　@after_week　までの日付を配列表示してLine-chart化
  def self.start_times(user, week_before, after_week)
    user.bodyweights.where( start_time: week_before..after_week).order(:start_time).pluck(:start_time)
  end
  
  # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
  def self.body_weights(user, week_before, after_week)
    user.bodyweights.where( start_time: week_before..after_week).order(:start_time).pluck(:body_weight)
  end
  
  # -------- 体脂肪率 --------
  
  # 最新の体脂肪率
  def self.newwest_bodyfat_percentage(user)
    user.bodyweights.order(:bodyfat_percentage).limit(1).pluck(:bodyfat_percentage)
  end
  
  # 最新の体脂肪率の記録日
  def self.newwest_bodyfat_percentage_starttime(user, newwest_bodyfat_percentage, target_weight)
    if newwest_bodyfat_percentage == [nil]
      target_weight.updated_at
    else
      user.bodyweights.order(:bodyfat_percentage).limit(1).pluck(:start_time).sum
    end
  end
  
  # 落とす体脂肪率
  def self.now_bodyfat_percentage_pull_goal_bodyfat_percentage(newwest_bodyfat_percentage, target_weight)
    if newwest_bodyfat_percentage == [nil]
      target_weight.now_bodyfat_percentage - target_weight.goal_bodyfat_percentage
    else
      (target_weight.now_bodyfat_percentage - newwest_bodyfat_percentage.sum) - (target_weight.now_bodyfat_percentage - target_weight.goal_bodyfat_percentage)
    end
  end
  
  # 体脂肪率の進捗
  def self.progress_bodyfat_percentage(newwest_bodyfat_percentage, target_weight)
    if newwest_bodyfat_percentage == [nil]
      0
    else
      target_weight.now_bodyfat_percentage - newwest_bodyfat_percentage.sum
    end
  end
  
  # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
  def self.bodyfat_percentages(user, week_before, after_week)
    user.bodyweights.where( start_time: week_before..after_week).order(:start_time).pluck(:bodyfat_percentage)
  end
  
end
