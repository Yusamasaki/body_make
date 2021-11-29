class TodaymealRecipe < ApplicationRecord
  
  belongs_to :user
  belongs_to :timezone
  belongs_to :recipe
  
  validates :amount, presence: true, numericality: { in: 0..100 }
  
end
