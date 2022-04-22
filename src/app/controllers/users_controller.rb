class UsersController < ApplicationController
  
  before_action :authenticate_admin!, only: [:index, :detail]
  before_action :authenticate_user!, only: [:show, :setting]
  before_action :first_setting, only: :show
  before_action :set_user, only: [:show, :setting]
  before_action :set_basic, only: [:show, :setting]
  before_action :set_bmr, only: :setting
  before_action :start_time_next_valid, only: :show
  
  def first_setting
    if current_user.bmr.present?
      return
    else
      redirect_to new_user_bmr_path(current_user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    end
  end

  def index
  end

  def detail
    @user = User.find(params[:user_id])
  end
  
  def show
    
    # ========== ログインユーザーのPfcRatioモデルのCreateが無ければCreate ==========
    if @pfc.nil?
      PfcRatio.create!(user_id: @user.id, protein: 20, fat: 20, carbo: 60)
    end
    
    # ========== ログインユーザーのBodyWeightモデルのCreateが無ければ一か月分Create ==========
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
    
    # ========== トレーニング部位別回復状況Data ==========
      bodyparts = Bodypart.all
      @bodypart_recoverys = bodyparts.map{|bodypart|
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

    # ========== graphのDataなど ==========

      # ========== 体重計算 ==========

        # 選択している日の1週間前
        @week_before = params[:start_time].to_date.ago(7.days)

        # week_beforeの2週間後
        @after_week = @week_before.since(14.days)
        
        # params[:start_time]別のrecord
        @body_weight = @user.bodyweights.find_by(start_time: params[:start_time])

        # 最新の体重
        @newwest_bodyweight = Bodyweight.newwest_bodyweight_get(@user)

        # 最新の体重の記録日
        @newwest_bodyweight_starttime = Bodyweight.newwest_bodyweight_starttime(@user, @newwest_bodyweight, @target_weight)

        # 落とす体重
        @now_body_weight_pull_goal_body_weight = Bodyweight.now_body_weight_pull_goal_body_weight(@newwest_bodyweight, @target_weight)

        # 体重の進捗
        @progress_bodyweight = Bodyweight.progress_bodyweight(@newwest_bodyweight, @target_weight)

        # ========== gonでcheat.jsに変数定義 ==========

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


      # ========== 体脂肪率計算 ==========

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
