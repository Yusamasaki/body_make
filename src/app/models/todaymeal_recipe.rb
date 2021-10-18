class TodaymealRecipe < ApplicationRecord
  
  belongs_to :user
  belongs_to :timezone
  belongs_to :recipe
  
end
