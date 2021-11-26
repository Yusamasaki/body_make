class Todaymeal < ApplicationRecord
  
  belongs_to :user
  belongs_to :myfood
  
  validates :amount, presence: true, numericality: { in: 0..100 }
end
