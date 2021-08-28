class ExerciseCategory < ApplicationRecord
  has_many :exercise_contents, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 30 }
end
