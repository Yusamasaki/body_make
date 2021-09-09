class Recipefood < ApplicationRecord
  belongs_to :User
  belong_to :recipe

  validates :food_name, length: { maximum: 100 }
  validates :amount, length: { maximum: 10000 }
  validates :calorie, length: { maximum: 10000 }
  validates :protein, length: { maximum: 1000 }
  validates :fat, length: { maximum: 10000 }
  validates :carbo, length: { maximum: 1000 }
  validates :suger, length: { maximum: 1000 }
  validates :dietary_fiber, length: { maximum: 1000 }
  validates :salt, length: { maximum: 1000 }
end
