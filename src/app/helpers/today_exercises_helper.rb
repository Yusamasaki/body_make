module TodayExercisesHelper
  def category(exercise)
    ExerciseCategory.find(exercise.exercise_category_id).name if exercise.exercise_category_id.present?
  end

  def content(exercise)
    ExerciseContent.find(exercise.exercise_content_id).content if exercise.exercise_content_id.present?
  end

  # 1日の運動時間合計
  def sum_today_exercise_time(exercise)
    total_min =
      @user.today_exercise.where(start_time: params[:start_time]).map {
        |exercise| (exercise.exercise_time_hour * 60) + (exercise.exercise_time_min)
      }.sum

    hour = (total_min / 60)
    exercise_hour = hour.to_s + '時間' if 0 < hour

    min = total_min - (hour * 60)
    exercise_min = min.to_s + '分' if 0 < min

    exercise_hour.to_s + exercise_min.to_s
  end

  # 1件当たりのカロリー計算
  def mets(exercise)
    if exercise.exercise_content_id.present?
      mets = ExerciseContent.find(exercise.exercise_content_id).mets
      body_weight = exercise.body_weight
      exercise_hour = exercise.exercise_time_hour * 60
      exercise_min = exercise.exercise_time_min
      exercise_time = ((exercise_hour + exercise_min) / 60.to_f)
      calorie = (mets.rationalize * body_weight.rationalize * exercise_time.rationalize * 1.05.rationalize).to_f # 消費カロリー = (メッツ * 体重kg * 運動時間 * 1.05)
      calorie
    end
  end

  # 1日の運動カロリー合計
  def sum_mets
    mets =
      @today_exercises.map { |exercise|
        mets(exercise) if exercise.exercise_content_id.present?
      }.compact
    mets.sum
  end

  def exercise_hour(exercise)
    exercise.exercise_time_hour.to_s + "時間" unless exercise.exercise_time_hour == 0
  end

  def exercise_min(exercise)
    exercise.exercise_time_min.to_s + "分" unless exercise.exercise_time_min == 0
  end
end
