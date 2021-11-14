class Todaymeal < ApplicationRecord
  
  belongs_to :user
  belongs_to :myfood
  
end
