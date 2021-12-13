class TodaymealRecipe < ApplicationRecord
  
  belongs_to :user
  belongs_to :timezone
  belongs_to :recipe
  
  validates :amount, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, message: " : 1 ~ 1000 までの数値を入力ください。"}
  validates :note, length: {maximum: 100}
  
end
