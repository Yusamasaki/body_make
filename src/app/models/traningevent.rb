class Traningevent < ApplicationRecord
  belongs_to :user
  
  has_many :today_tranings
  
  validates :traning_name, presence: true, length: { maximum: 30 }
  validates :sub_body_part, presence: true, length: { maximum: 30 }
  
end
