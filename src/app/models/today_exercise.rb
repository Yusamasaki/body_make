class TodayExercise < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :exercise_time, presence: true
  validates :note, length: { maximum: 30 }
  # validates :exercise_category_id, presence: true
  # validates :exercise_content_id, presence: true
  validates :user_id, presence: true
end
