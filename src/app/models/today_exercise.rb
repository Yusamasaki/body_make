class TodayExercise < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :exercise_time_hour, presence: true, numericality: { only_integer: true, less_than: 24 }
  validates :exercise_time_min, presence: true, numericality: { only_integer: true, less_than: 60 }
  validates :body_weight, presence: true, numericality: { less_than_or_equal_to: 500 }
  validates :note, length: { maximum: 30 }
  validates :user_id, presence: true
end
