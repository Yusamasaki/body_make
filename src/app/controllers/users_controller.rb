class UsersController < ApplicationController

  before_action :logged_in_user, only: [:first_setting, :show, :setting]
  before_action :first_setting, only: :show
  before_action :today_exercise_set_one_month, only: [:show]
  before_action :set_user, only: [:show, :setting]
  before_action :set_basic, only: [:show, :setting]
  before_action :set_bmr, only: [:setting]
  before_action :start_time_next_valid, only: [:show]

  def first_setting
    if current_user.bmr.present?
      return
    else
      redirect_to new_user_bmr_path(current_user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    end
  end

  def show

    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month

    one_month = [*@first_day..@last_day]

    @bodyweights = @user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time)

    unless one_month.count == @bodyweights.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.bodyweights.create!(start_time: day) }
      end
      @bodyweights = @user.bodyweights.where(start_time: @first_day..@last_day).order(:start_time)
    end

    @body_weight = @user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = @user.bodyweights.all
    @bodyparts = Bodypart.all

    @bodypart_recoverys = @bodyparts.map{|bodypart|
      current_day = Time.current.to_date.yday
      record_day = @user.today_tranings.where(bodypart_id: bodypart).order(start_time: :desc).limit(1).pluck(:start_time)
      [
        bodypart,
        if record_day.present?
          if (current_day - record_day.sum.yday) <= bodypart.recovery_day
            (current_day - record_day.sum.yday)
          else
            bodypart.recovery_day
          end
        else
          bodypart.recovery_day
        end
        ]
    }.map{|bodypart, current|
      recovery_parcentage = ((current / bodypart.recovery_day.to_f) * 100)
      [recovery_parcentage, bodypart, current]
    }

    # 最新のレコード(start_time)
    today_tranings_1 = @user.today_tranings.where(bodypart_id: 1).order(start_time: :desc).limit(1).pluck(:start_time).sum
      # 最新のレコード(start_time) - 本日の日にち
      gon.today_tranings_1_recovery = (today_tranings_1.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_1 == 0
      # (最新のレコード(start_time) - 本日の日にち) - 各部位回復日数
      gon.today_tranings_1_recovery_1 = (gon.today_tranings_1_recovery - 3).abs unless today_tranings_1 == 0

    today_tranings_2 = @user.today_tranings.where(bodypart_id: 2).order(start_time: :desc).limit(1).pluck(:start_time).sum
      gon.today_tranings_2_recovery = (today_tranings_2.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_2 == 0
      gon.today_tranings_2_recovery_2 = (gon.today_tranings_2_recovery - 3).abs unless today_tranings_2 == 0

    today_tranings_3 = @user.today_tranings.where(bodypart_id: 3).order(start_time: :desc).limit(1).pluck(:start_time).sum
      gon.today_tranings_3_recovery = (today_tranings_3.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_3 == 0
      gon.today_tranings_3_recovery_3 = (gon.today_tranings_3_recovery - 3).abs unless today_tranings_3 == 0

    today_tranings_4 = @user.today_tranings.where(bodypart_id: 4).order(start_time: :desc).limit(1).pluck(:start_time).sum
      gon.today_tranings_4_recovery = (today_tranings_4.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_4 == 0
      gon.today_tranings_4_recovery_4 = (gon.today_tranings_4_recovery - 2).abs unless today_tranings_4 == 0

    today_tranings_5 = @user.today_tranings.where(bodypart_id: 5).order(start_time: :desc).limit(1).pluck(:start_time).sum
      gon.today_tranings_5_recovery = (today_tranings_5.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_5 == 0
      gon.today_tranings_5_recovery_5 = (gon.today_tranings_5_recovery - 2).abs unless today_tranings_5 == 0

    today_tranings_6 = @user.today_tranings.where(bodypart_id: 6).order(start_time: :desc).limit(1).pluck(:start_time).sum
      gon.today_tranings_6_recovery = (today_tranings_6.to_date.yday - Time.current.to_date.yday).abs unless today_tranings_6 == 0
      gon.today_tranings_6_recovery_6 = (gon.today_tranings_6_recovery - 1).abs unless today_tranings_6 == 0


    # --------- graphのDataなど ---------

      # --------- 体重計算 ---------

        # 選択している日の1週間前
        @week_before = params[:start_time].to_date.ago(7.days)

        # week_beforeの2週間後
        @after_week = @week_before.since(14.days)

        # 最新の体重
        @newwest_bodyweight = Bodyweight.newwest_bodyweight_get(@user)

        # 最新の体重の記録日
        @newwest_bodyweight_starttime = Bodyweight.newwest_bodyweight_starttime(@user, @newwest_bodyweight, @target_weight)

        # 落とす体重
        @now_body_weight_pull_goal_body_weight = Bodyweight.now_body_weight_pull_goal_body_weight(@newwest_bodyweight, @target_weight)

        # 体重の進捗
        @progress_bodyweight = Bodyweight.progress_bodyweight(@newwest_bodyweight, @target_weight)

        # -------- gonでcheat.jsに変数定義 --------

        # 目標体重
        gon.goal_body_weight = @target_weight.goal_body_weight

        # @week_before　〜　@after_week　までの日付を配列表示してLine-chart化
        gon.start_times = Bodyweight.start_times(@user, @week_before, @after_week).map{|day| day.day }

        # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
        gon.body_weights = Bodyweight.body_weights(@user, @week_before, @after_week)

        # 体重グラフX軸上限値
        gon.newwest_bodyweight_high_with = (@newwest_bodyweight.sum + 20).floor

        # 体重グラフX軸下限値
        gon.newwest_bodyweight_low_with = (@newwest_bodyweight.sum - 20).floor

        # gonで体重グラフデータ化
        gon.body_weight_area = [@progress_bodyweight.floor(1).abs] + [@now_body_weight_pull_goal_body_weight.floor(1).abs]


      # --------- 体脂肪率計算 ---------

        # 最新の体脂肪率
        @newwest_bodyfat_percentage = Bodyweight.newwest_bodyfat_percentage(@user)

        # 最新の体脂肪率の記録日
        @newwest_bodyfat_percentage_starttime = Bodyweight.newwest_bodyfat_percentage_starttime(@user, @newwest_bodyfat_percentage, @target_weight)

        # 落とす体脂肪率
        @now_bodyfat_percentage_pull_goal_bodyfat_percentage = Bodyweight.now_bodyfat_percentage_pull_goal_bodyfat_percentage(@newwest_bodyfat_percentage, @target_weight)


        # 体脂肪率の進捗
        @progress_bodyfat_percentage = Bodyweight.progress_bodyfat_percentage(@newwest_bodyfat_percentage, @target_weight)

        # 目標の体脂肪率
        gon.goal_bodyfat_percentage = @target_weight.goal_bodyfat_percentage


        # @week_before　〜　@after_week　までの体重を配列表示してLine-chart化
        gon.bodyfat_percentages = Bodyweight.bodyfat_percentages(@user, @week_before, @after_week)

        # 体重グラフX軸上限値
        gon.newwest_bodyfat_percentage_high_with = (@newwest_bodyfat_percentage.sum + 20).floor

        # 体重グラフX軸下限値
        gon.newwest_bodyfat_percentage_low_with = (@newwest_bodyfat_percentage.sum - 20).floor

        # gonで体重グラフデータ化
        gon.bodyfat_percentage_area = [@progress_bodyfat_percentage.floor(1).abs] + [@now_bodyfat_percentage_pull_goal_bodyfat_percentage.floor(1).abs]

  end

  def setting
    # 最新の体重
    @newwest_bodyweight = Bodyweight.newwest_bodyweight_get(@user)
  end

end
