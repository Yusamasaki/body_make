class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefoods, dependent: :destroy
  has_many :todaymeal_recipes, dependent: :destroy

  validates :recipe_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :user }
  
  def self.search_recipe(search)
    if search.present?
      Recipe.where(['recipe_name LIKE ?', "%#{search}%"])
    else
      Recipe.all.order(id: "DESC")
    end
  end
  
end