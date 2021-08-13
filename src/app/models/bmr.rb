class Bmr < ApplicationRecord
  belongs_to :user

  validates :gender, presence: true
  validates :age, presence: true, length: { maximum: 3 }
  validates :height, presence: true, length: { maximum: 3 } 
end
