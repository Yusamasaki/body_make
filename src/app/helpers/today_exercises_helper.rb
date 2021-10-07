module TodayExercisesHelper
  def category(exercise)
    ExerciseCategory.find(exercise.exercise_category_id).name if exercise.exercise_category_id.present?
  end

  def content(exercise)
    ExerciseContent.find(exercise.exercise_content_id).content if exercise.exercise_content_id.present?
  end

  def calorie(exercise)
    ExerciseContent.find(exercise.exercise_content_id).calorie if exercise.exercise_content_id.present?
  end

  def sum_calorie
    calorie =
      @today_exercises.map { |exercise|
        ExerciseContent.find(exercise.exercise_content_id).calorie if exercise.exercise_content_id.present?
      }.compact
    calorie.sum
  end
end
