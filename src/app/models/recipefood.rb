class Recipefood < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :myfood
end
