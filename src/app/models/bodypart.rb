class Bodypart < ApplicationRecord
  has_many :sub_bodyparts
  has_many :traningevents
  has_many :today_tranings
end
