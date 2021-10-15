class Myfood < ApplicationRecord
   belongs_to :user
   has_many :todaymeals

   validates :food_name, length: { maximum: 100 }
   # validates :amount, numericality: { less_than_or_equal_to: 10000 }
   # validates :calorie, numericality: { less_than_or_equal_to: 10000 }
   # validates :protein, numericality: { less_than_or_equal_to: 1000 }
   # validates :fat, numericality: { less_than_or_equal_to: 1000 }
   # validates :carbo, numericality: { less_than_or_equal_to: 1000 }
   # validates :sugar, numericality: { less_than_or_equal_to: 1000 }
   # validates :dietary_fiber, numericality: { less_than_or_equal_to: 1000 }
   # validates :salt, numericality: { less_than_or_equal_to: 1000 }
end
