class Recipefood < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :myfood
  
  validates :amount, numericality: { :greater_than_or_equal_to => 1 }
end
