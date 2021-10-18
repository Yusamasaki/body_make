class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefood, dependent: :destroy

  validates :recipe_name, length: { maximum: 100 }
  
end