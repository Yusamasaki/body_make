class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipefood, dependent: :destroy
  accepts_nested_attributes_for :recipefood, allow_destroy: true

  validates :recipe_name, length: { maximum: 100 }
  
end