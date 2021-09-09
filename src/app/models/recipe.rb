class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefood, dependent: :destroy
  accepts_nested_attributes_for :recipefood, allow_destroy: true

  validates :recipe_name, length: { maximum: 100 }
  validates :calorie, length: { maximum: 10000 }
  validates :protein, length: { maximum: 10000 }
  validates :fat, length: { maximum: 10000 }
  validates :carbo, length: { maximum: 1000 }
  validates :suger, length: { maximum: 1000 }
  validates :dietary_fiber, length: { maximum: 1000 }
  validates :salt, length: { maximum: 1000 }
  validates :note, length: {maximum: 1000 }
end
