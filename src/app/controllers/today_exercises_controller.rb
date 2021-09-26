class TodayExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_categories, only: [:new, :create, :edit]
  before_action :set_contents, only: [:new, :create, :edit, :new_contents, :edit_contents]

  def index
    # @today_exercise = TodayExercise.find(params[:id])
    @today_exercises = TodayExercise.where(start_time: params[:start_time])
  end

  def new
    @today_exercise = TodayExercise.new
  end

  def create
    @today_exercise = current_user.today_exercise.build(exercise_params)
    if @today_exercise.save
      flash[:success] = "新規作成しました。"
      redirect_to user_today_exercises_url(user_id: current_user, start_date: params[:start_date], start_time: params[:start_time])
    else
      render :new
    end
  end

  def edit
    @today_exercise = current_user.today_exercise.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @today_exercise = current_user.today_exercise.find(params[:id])
      if @today_exercise.update_attributes!(exercise_params)
        flash[:success] = "#{@today_exercise.start_time}の運動を記録しました"
        redirect_to user_today_exercises_path(user_id: current_user, id: @today_exercise, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "記録に失敗しました。"
        redirect_to edit_user_today_exercise_path(user_id: current_user, id: @today_exercise, start_date: params[:start_date], start_time: params[:start_time])
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to edit_user_today_exercise_path(user_id: current_user, id: @today_exercise, start_date: params[:start_date], start_time: params[:start_time])
    # redirect_to edit_user_today_exercise_path(user_id: current_user, id: @today_exercise, start_date: params[:start_date], start_time: params[:start_time])
  end

  def new_contents
  end

  def edit_contents
  end

  def calender
    @today_exercise = current_user.today_exercises.find_by(start_time: params[:start_time])
    @today_exercises = current_user.today_exercises.all
  end

  private

    def set_exercise
      @exercise = TodayExercise.find(params[:id])
    end

    def set_categories
      @categories = ExerciseCategory.all.order(:id)
    end

    def set_contents
      @contents = ExerciseContent.where(exercise_category_id: params[:exercise_category_id])
    end

    def exercise_params
      params.require(:today_exercise).permit(:start_time, :exercise_time, :note, :exercise_category_id, :exercise_content_id, :user_id)
    end
end
