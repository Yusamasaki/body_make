class Bodypart < ApplicationRecord
  has_many :sub_bodyparts
  
  validates :body_part, presence: true
end
