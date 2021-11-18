class Traningevent < ApplicationRecord
  belongs_to :user
  belongs_to :bodypart
  
  has_many :today_tranings, dependent: :destroy
  has_many :traning_analysis, dependent: :destroy
  has_many :subbodyparts, dependent: :destroy
  
  
  validates :traning_name, presence: true, length: { maximum: 30 }, uniqueness: true
  
end
