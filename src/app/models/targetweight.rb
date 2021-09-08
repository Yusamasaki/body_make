class Targetweight < ApplicationRecord
  belongs_to :user

  validates :now_body_weight, presence: true
  validates :goal_body_weight, presence: true
  validates :now_bodyfat_percentage, presence: true
  validates :goal_bodyfat_percentage, presence: true
  validates :target_days, presence: true
end
