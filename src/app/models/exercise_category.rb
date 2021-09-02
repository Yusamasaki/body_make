class ExerciseCategory < ApplicationRecord
  has_many :exercise_contents, dependent: :destroy
  accepts_nested_attributes_for :exercise_contents, allow_destroy: true
  
  validates :name, presence: true, length: { maximum: 30 }
end
