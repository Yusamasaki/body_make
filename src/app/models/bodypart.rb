class Bodypart < ApplicationRecord
  has_many :sub_bodyparts
  has_many :traningevents
end
