class ExerciseContent < ApplicationRecord
  belongs_to :exercise_category

  validates :content, presence: true, length: { maximum: 20 }
  validates :mets, presence: true, numericality: { less_than_or_equal_to: 999 }
end
