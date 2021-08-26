class Bodyweight < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  
  # 体重が存在しない場合体脂肪率は無効、どちらも存在しない場合無効。
  validate :body_weight_is_invalid_without_a_bodyfat_percentage
  
  def body_weight_is_invalid_without_a_bodyfat_percentage
    if body_weight.blank? && bodyfat_percentage.present? || body_weight.blank? && bodyfat_percentage.blank?
      errors.add(:body_weight, "が必要です")
    end
  end
end
