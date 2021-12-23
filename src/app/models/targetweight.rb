class Targetweight < ApplicationRecord
  belongs_to :user

  validates :now_body_weight, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 200, message: " : 1 ~ 200 までの数値を入力ください。"}
  validates :goal_body_weight, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 200, message: " : 1 ~ 200 までの数値を入力ください。"}
  validates :now_bodyfat_percentage, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: " : 0 ~ 100 までの数値を入力ください。"}
  validates :goal_bodyfat_percentage, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: " : 0 ~ 100 までの数値を入力ください。"}
  validates :beginning_date, presence: true
  validates :target_date, presence: true

  validate :beginning_date_than_target_date_fast_if_invalid

  def beginning_date_than_target_date_fast_if_invalid
    if beginning_date.present? && target_date.present?
      errors.add(:beginning_date, "より前の日にちは無効です") if beginning_date > target_date
    end
  end
end
