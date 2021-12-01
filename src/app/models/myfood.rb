class Myfood < ApplicationRecord
   belongs_to :user
   has_many :todaymeals, dependent: :destroy
   has_many :recipefoods, dependent: :destroy

   validates :food_name, presence: true, length: { maximum: 100 }, uniqueness: true
   validates :calorie, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10000, message: " : Please input 0~10000"}
   validates :protein, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :fat, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :carbo, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :sugar, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :dietary_fiber, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   validates :salt, numericality: {only_float: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000, message: " : Please input 0~1000"}
   
   def self.search_food(search)
      if search.present?
        Myfood.where(['food_name LIKE ?', "%#{search}%"])
      else
        Myfood.all.order(id: "DESC")
      end
   end
end
