class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefoods, dependent: :destroy
  has_many :todaymeal_recipes, dependent: :destroy

  validates :recipe_name, presence: true, length: { maximum: 100 }, uniqueness: true
  
  
end