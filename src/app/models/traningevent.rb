class Traningevent < ApplicationRecord
  belongs_to :user
  
  validates :traning_name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :sub_body_part, presence: true, length: { maximum: 30 }
  
end
