class Recipefood < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :myfood
  
  validates :amount, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: " : 1 ~ 100 までの数値を入力ください。"}
  
end
