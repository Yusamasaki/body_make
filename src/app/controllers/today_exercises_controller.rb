class TodayExercisesController < ApplicationController
  include TodayExercisesHelper
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_basic, only: [:index]
  before_action :today_exercise_set_one_month, only: [:index]
  before_action :set_categories, only: [:index, :new, :create, :edit]
  before_action :set_contents, only: [:index, :new, :create, :edit, :new_contents, :edit_contents]
  before_action :set_today_exercise, only: [:edit, :update, :destroy]

  def index
    @today_exercises = @user.today_exercise.where(start_time: params[:start_time]).order(:id)

    month_before = params[:start_time].to_date.beginning_of_month
    after_month = month_before.end_of_month
    gon.start_times = [*month_before.day..after_month.day]
    month_body_weights = [@user.today_exercise.where(start_time: month_before..after_month).group(:start_time).sum(:body_weight).values]
@test =
    gon.calorie = 
      @user.today_exercise.where(start_time: month_before..after_month).order(:id).group_by { |exercise| exercise.start_time }.map { |start_time, value|
        [
          # ((((value.sum { |exercise| exercise.exercise_content_id == nil || exercise.exercise_time_hour == 0 && exercise.exercise_time_min == 0 ? 0 : ExerciseContent.find(exercise.exercise_content_id.to_i).mets }) \
          # * ([:body_weight] == nil ? 0 : (value.map(&:body_weight)[1]).to_f) \
          # * (((value.map(&:exercise_time_hour).sum * 60) + (value.map(&:exercise_time_min).sum)) / 60.to_f)).round(2)) * 1.05 \
          # / (value.count - value.sum { |exercise|(exercise.exercise_content_id == nil || exercise.exercise_time_hour == 0 && exercise.exercise_time_min == 0 ? 1 : 0)})).round(2),

          # [mets: value.sum { |exercise| exercise.exercise_content_id == nil || exercise.exercise_time_hour == 0 && exercise.exercise_time_min == 0 ? 0 : ExerciseContent.find(exercise.exercise_content_id.to_i).mets }],
          # [body: ([:body_weight] == nil ? 0 : (value.map(&:body_weight)[1]).to_f)],
          # [time: ((value.map(&:exercise_time_hour).sum * 60) + (value.map(&:exercise_time_min).sum)) / 60.to_f],
          # [count: value.count - value.sum { |exercise|(exercise.exercise_content_id == nil || exercise.exercise_time_hour == 0 && exercise.exercise_time_min == 0 ? 1 : 0)}],

          value.drop(1).sum { |exercise|
            (((exercise.exercise_time_hour * 60) + (exercise.exercise_time_min)) / 60.to_f) \
            * ExerciseContent.find(exercise.exercise_content_id.to_i).mets \
            * (value.map(&:body_weight)[1]).to_f \
            * 1.05
          }
        ]
      }
  end

  def new
    @today_exercise = TodayExercise.new
    @category_params = params[:exercise_category_id]
    @content_params = params[:exercise_content_id]
    @now_body_weight = @user.targetweight.now_body_weight unless params[:recipe_id].present?
  end

  def create
    @today_exercise = current_user.today_exercise.build(exercise_params)
    if @today_exercise.save
      flash[:success] = "新規作成しました。"
      redirect_to user_today_exercises_url(
        user_id: current_user, start_date: params[:start_date], start_time: params[:start_time]
      )
    else
      render :new
    end
  end

  def edit
    @category_params = params[:exercise_category_id]
    @content_params = params[:exercise_content_id]
  end

  def update
    ActiveRecord::Base.transaction do
      if @today_exercise.update_attributes!(exercise_params)
        flash[:success] = "#{@today_exercise.start_time}の運動を記録しました"
        redirect_to user_today_exercises_path(
          user_id: current_user,
          id: @today_exercise,
          start_date: params[:start_date],
          start_time: params[:start_time]
        )
      else
        flash[:danger] = "記録に失敗しました。"
        redirect_to edit_user_today_exercise_path(
          user_id: current_user,
          id: @today_exercise,
          start_date: params[:start_date],
          start_time: params[:start_time]
        )
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to edit_user_today_exercise_path(
        user_id: current_user,
        id: @today_exercise,
        start_date: params[:start_date],
        start_time: params[:start_time]
      )
  end

  def destroy
    @today_exercise.destroy
    redirect_to user_today_exercises_path(
      user_id: current_user,
      id: @today_exercise,
      start_date: params[:start_date],
      start_time: params[:start_time]
      ),
      flash: { danger: "運動内容を1件削除しました。"}
  end

  def new_contents
  end

  def edit_contents
  end

  def calender
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    @today_exercise = current_user.today_exercise.find_by(start_time: params[:start_time])
    @today_exercises = current_user.today_exercise.all
  end

  private

    def set_today_exercise
      @today_exercise = current_user.today_exercise.find(params[:id])
    end

    def set_categories
      @categories = ExerciseCategory.all.order(:id)
    end

    def set_contents
      @contents = ExerciseContent.where(exercise_category_id: params[:exercise_category_id])
    end

    def exercise_params
      params.require(:today_exercise).permit(:start_time, :exercise_time_hour, :exercise_time_min, :body_weight, :note, :exercise_category_id, :exercise_content_id, :user_id)
    end
end
