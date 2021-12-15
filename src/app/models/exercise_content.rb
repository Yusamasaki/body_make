class ExerciseContent < ApplicationRecord
  belongs_to :exercise_category

  validates :content, presence: true, length: { maximum: 20 }
  validates :mets, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999 }
end
