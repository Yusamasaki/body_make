class Todaymeal < ApplicationRecord
  
  belongs_to :user
  belongs_to :myfood
  
  validates :amount, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10000, message: " : 1 ~ 10000 までの数値を入力ください。"}
end
