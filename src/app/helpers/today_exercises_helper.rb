module TodayExercisesHelper
  def category(exercise)
    ExerciseCategory.find(exercise.exercise_category_id).name if exercise.exercise_category_id.present?
  end

  def content(exercise)
    ExerciseContent.find(exercise.exercise_content_id).content if exercise.exercise_content_id.present?
  end

  def mets(exercise)
    if exercise.exercise_content_id.present?
      mets = ExerciseContent.find(exercise.exercise_content_id).mets
      body_weight = Targetweight.find_by(user_id: @user.id).now_body_weight
      exercise_hour = exercise.exercise_time.hour * 60
      exercise_min = exercise.exercise_time.min
      exercise_time = ((exercise_hour + exercise_min) / 60.to_f).round(2)
      calorie = mets * body_weight * exercise_time * 1.05 # 消費カロリー = (メッツ * 体重kg * 運動時間 * 1.05)
      calorie.round(2)
    end
  end

  def sum_mets
    mets =
      @today_exercises.map { |exercise|
        mets(exercise) if exercise.exercise_content_id.present?
      }.compact
    mets.sum
  end
end
