class Timezone < ApplicationRecord
  has_many :todaymeal_recipes
  has_many :todaymeals
  
  validates :time_zone, presence: true
end
