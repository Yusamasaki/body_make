class Targetweight < ApplicationRecord
  belongs_to :user

  validates :body_weight, presence: true
  validates :bodyfat_parcentag, presence: true
  validates :target_days, presence: true
end
