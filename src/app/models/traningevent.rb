class Traningevent < ApplicationRecord
  belongs_to :user
  
  has_many :today_tranings, dependent: :destroy
  has_many :traning_analysis, dependent: :destroy
  
  
  validates :traning_name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :sub_body_part, presence: true, length: { maximum: 30 }
  
end
