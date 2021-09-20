class TodayExercisesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @exercise = TodayExercise.new
  end

  def edit
    @today_exercise = current_user.today_exercise.find(params[:id])
    # @category = ExerciseContent.where(exercise_category_id: params[:exercise_category_id])
    # @categories = ExerciseCategory.all
    # @contents = ExerciseContent.all
    
  end

  def contents
    @contents = ExerciseContent.where(exercise_category_id: params[:exercise_category_id])
  end

  def create
    redirect_to new_user_today_exercise_path(current_user)
  end

  def calender
    @today_exercise = current_user.today_exercises.find_by(start_time: params[:start_time])
    @today_exercises = current_user.today_exercises.all
  end

  private

    def set_exercise
      @exercise = TodayExercise.find(params[:id])
    end

    def exercise_params
      params.require(:today_exercise).permit(:start_time, :exercise_time, :note, :exercise_category_id, :user_id)
    end
end
