class Timezone < ApplicationRecord
  has_many :my_meal
  accepts_nested_attributes_for :my_meal, allow_destroy: true
end
