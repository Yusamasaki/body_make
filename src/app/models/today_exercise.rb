class TodayExercise < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :exercise_time_hour, presence: true, numericaliity: { greater_than_or_equal_to: 0, less_than_or_equal_to: 23 }
  validates :exercise_time_min, presence: true, numericaliity: { greater_than_or_equal_to: 0, less_than_or_equal_to: 55 }
  validates :note, length: { maximum: 30 }
  # validates :exercise_category_id, presence: true
  # validates :exercise_content_id, presence: true
  validates :user_id, presence: true
end
