class Traningevent < ApplicationRecord
  belongs_to :user
  
  has_many :today_tranings, dependent: :destroy
  has_many :traning_analysis, dependent: :destroy
  
  
  validates :traning_name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user }
  validates :bodypart_id, presence: true
  validates :subbodypart_id, presence: true
  validates :traningtype_id, presence: true
  
end
