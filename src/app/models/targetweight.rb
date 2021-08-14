class Targetweight < ApplicationRecord
  belongs_to :user

  validates :body_weight, presence: true
  validates :bodyfat_parcentage, presence: true
end
