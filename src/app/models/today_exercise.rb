class TodayExercise < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :exercise_time_hour, presence: true, numericality: { only_integer: true, less_than: 23 }
  validates :exercise_time_min, presence: true, numericality: { only_integer: true, less_than: 60 }
  validates :note, length: { maximum: 30 }
  validates :user_id, presence: true
end
