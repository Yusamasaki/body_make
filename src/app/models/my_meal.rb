class MyMeal < ApplicationRecord
  belongs_to :user
  belongs_to :timezone

  validates :food_name, length: { maximum: 100 }
  validates :calorie, numericality: { less_than_or_equal_to: 10000 }
  validates :protein, length: { less_than_or_equal_to: 1000 }
  validates :fat, numericality: { less_than_or_equal_to: 1000 }
  validates :carbo, numericality: { less_than_or_equal_to: 1000 }
  validates :suger, numericality: { less_than_or_equal_to: 1000 }
  validates :dietary_fiber, numericality: { less_than_or_equal_to: 1000 }
  validates :salt, numericality: { less_than_or_equal_to: 1000 }
  validates :note, length: { maximum: 1000 }
end
