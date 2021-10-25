class Myfood < ApplicationRecord
   belongs_to :user
   has_many :todaymeals, dependent: :destroy
   has_many :recipefoods, dependent: :destroy

   validates :food_name, presence: true, length: { maximum: 100 }, uniqueness: true
   validates :calorie, presence: true, numericality: { less_than_or_equal_to: 10000 }
   validates :protein, presence: true, numericality: { less_than_or_equal_to: 1000 }
   validates :fat, presence: true, numericality: { less_than_or_equal_to: 1000 }
   validates :carbo, presence: true, numericality: { less_than_or_equal_to: 1000 }
   validates :sugar, presence: false, numericality: { less_than_or_equal_to: 1000 }
   validates :dietary_fiber, presence: false, numericality: { less_than_or_equal_to: 1000 }
   validates :salt, presence: false, numericality: { less_than_or_equal_to: 1000 }
end
