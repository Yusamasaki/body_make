class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefood, dependent: :destroy
  accepts_nested_attributes_for :recipefood, allow_destroy: true

  validates :recipe_name, length: { maximum: 100 }
  validates :calorie, numericality: { less_than_or_equal_to: 10000 }
  validates :protein, numericality: { less_than_or_equal_to: 1000 }
  validates :fat, numericality: { less_than_or_equal_to: 10000 }
  validates :carbo, numericality: { less_than_or_equal_to: 1000 }
  validates :suger, numericality: { less_than_or_equal_to: 1000 }
  validates :dietary_fiber, numericality: { less_than_or_equal_to: 1000 }
  validates :salt, numericality: { less_than_or_equal_to: 1000 }
  validates :note, length: {maximum: 1000 }
end