class Timezone < ApplicationRecord
  has_many :todaymeal_recipes
  has_many :todaymeals
end
