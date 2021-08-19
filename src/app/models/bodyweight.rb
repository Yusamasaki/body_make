class Bodyweight < ApplicationRecord
  belongs_to :user

  validates :body_weight, presence: true
  validates :bodyfat_percentage, presence: true
end
