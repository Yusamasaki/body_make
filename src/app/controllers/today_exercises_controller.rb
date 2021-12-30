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

    # チャート用の今月分の運動データ
    month_before = params[:start_time].to_date.beginning_of_month
    after_month = month_before.end_of_month
    gon.month_start_times = [*month_before.day..after_month.day]
    # month_body_weights = [@user.today_exercise.where(start_time: month_before..after_month).group(:start_time).sum(:body_weight).values]

    gon.month_calorie =
      @user.today_exercise.where(start_time: month_before..after_month).order(:id).group_by {|exercise| exercise.start_time }.map { |start_time, value|
        value.drop(1).sum { |exercise|
          ((((exercise.exercise_time_hour * 60).rationalize + (exercise.exercise_time_min)).rationalize / 60.rationalize) \
          * ExerciseContent.find(exercise.exercise_content_id.to_i).mets.rationalize \
          * exercise.body_weight.rationalize \
          * 1.05).to_f
        }
      }

    # チャート用の今週分の運動データ
    week_before = params[:start_time].to_date.beginning_of_week
    after_week = week_before.end_of_week
    if week_before.day > after_week.day
      gon.week_start_times = [week_before.day, (week_before + 1).day, (week_before + 2).day, (week_before + 3).day, (week_before + 4).day, (week_before + 5).day, (week_before + 6).day]
    else
      gon.week_start_times = [*week_before.day..after_week.day]
    end
    

    gon.week_calorie =
      @user.today_exercise.where(start_time: week_before..after_week).order(:id).group_by {|exercise| exercise.start_time }.map { |start_time, value|
        value.drop(1).sum { |exercise|
          ((((exercise.exercise_time_hour * 60).rationalize + (exercise.exercise_time_min).rationalize) / 60.rationalize) \
          * ExerciseContent.find(exercise.exercise_content_id.to_i).mets.rationalize \
          * exercise.body_weight.rationalize \
          * 1.05).to_f
        }
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
      redirect_to user_today_exercises_url(
        user_id: current_user, start_date: params[:start_date], start_time: params[:start_time]
      ), flash: { danger: "登録エラー"}
    end
  end

  def edit
    @category_params = params[:exercise_category_id]
    @content_params = params[:exercise_content_id]
  end

  def update
    if @today_exercise.update(exercise_params)
      flash[:success] = "#{@today_exercise.start_time}の運動を修正しました"
      redirect_to user_today_exercises_url(
        user_id: current_user,
        start_date: params[:start_date],
        start_time: params[:start_time]
      )
    else
      flash[:danger] = "記録に失敗しました。"
      redirect_to user_today_exercises_url(
        user_id: current_user,
        start_date: params[:start_date],
        start_time: params[:start_time]
      )
    end
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
