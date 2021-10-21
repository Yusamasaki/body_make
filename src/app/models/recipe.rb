class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefoods, dependent: :destroy

  validates :recipe_name, length: { maximum: 100 }, uniqueness: true
  
  
end