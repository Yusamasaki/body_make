class ExerciseContent < ApplicationRecord
  belongs_to :exercise_category

  validates :content, presence: true, length: { maximum: 20 }
  validates :mets, presence: true, length: { maximum: 10 }
end
