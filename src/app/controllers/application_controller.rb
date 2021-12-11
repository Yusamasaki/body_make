class ApplicationController < ActionController::Base
  
  # 小数点の誤差をなくす
  require 'bigdecimal'
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
  def set_user
    @user = current_user
  end
  
  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless user_signed_in?.to_s == "true"
      # store_location
      flash[:danger] = "ログインしてください。"
      redirect_to root_url
    end
  end
  
  # ログアウト済みのユーザーか確認。
  def log_out_user
    redirect_to user_path(current_user, start_date: Date.current.beginning_of_month, start_time: Date.current) if user_signed_in?
  end
    
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    redirect_to(users_url) unless current_user?(@user)
  end
  
  # 基礎代謝　＆　目標設定
  def set_basic
    @bmr = @user.bmr
    @target_weight = @user.targetweight
    @pfc = @user.pfc_ratio
  end
  
  def set_bmr
    # 最新の体重
    @newwest_bodyweight = Bodyweight.newwest_bodyweight_get(@user)
    # 基礎代謝
    @bmr_format = Bmr.bmr_format(@bmr.gender, @target_weight.now_body_weight, @newwest_bodyweight.sum, @bmr.height, @bmr.age).floor(1)
    # 1日の消費カロリー
    @day_calorie = Bmr.day_calorie(@bmr_format, @bmr.activity).floor(1)
    # 目標の摂取カロリー
    @day_target_calorie = Bmr.day_target_calorie(@day_calorie.floor(1), @target_weight)
    # 目標のPFCバランス（グラム・カロリー）
    if @pfc.present?
      @target_pfcs = [["たんぱく質", @pfc.protein, 4 ], ["脂質", @pfc.fat, 9], ["炭水化物", @pfc.carbo, 4]].map{|name, ratio, per_1g|
        [name, PfcRatio.pfc_calorie_format(@day_target_calorie, ratio), (PfcRatio.pfc_calorie_format(@day_target_calorie, ratio) / per_1g).floor(1), ratio]
      }
    else
      @target_pfcs = [["たんぱく質", 20, 4 ], ["脂質", 20, 9], ["炭水化物", 60, 4]].map{|name, ratio, per_1g|
        [name, PfcRatio.pfc_calorie_format(@day_target_calorie, ratio), (PfcRatio.pfc_calorie_format(@day_target_calorie, ratio) / per_1g).floor(1), ratio]
      }
    end
    
    # 目標のPFCカロリー
    if @pfc.present?
      target_pfc_calorie = [[20, 4, @pfc.protein], [20, 9, @pfc.fat], [60, 4, @pfc.carbo]].map{|ratio, per_1g, ratio_new|
        [PfcRatio.pfc_calorie_format(@day_target_calorie, ratio_new), per_1g, @day_target_calorie]
      }
    else
      target_pfc_calorie = [[20, 4], [20, 9], [60, 4]].map{|ratio, per_1g|
        [PfcRatio.pfc_calorie_format(@day_target_calorie, ratio), per_1g, @day_target_calorie]
      }
    end
    # グラフ値
    gon.pfc_calorie_ratios = target_pfc_calorie.map{|pfc_calorie, per_1g, day_target_calorie| ((pfc_calorie / day_target_calorie) * 100).floor(1)}

    
  end
  
  # アクセスした先のが明日以上の場合返す
  def start_time_next_valid
    if params[:start_time].to_s > Time.current.to_s
      flash[:danger] = "明日以上の記録はできません"
      redirect_to user_path(current_user, start_time: Date.current, start_date: Date.current.beginning_of_month)
      
    end
  end
  
  # ---------トレーニング関連---------
  
  def set_traningevent
    if params[:traningevent_id].present?
      @traningevent = @user.traningevents.find(params[:traningevent_id])
    else
      @traningevent = @user.traningevents.find(params[:id])
    end
  end
  
  # ------トレーニンググラフ------
  def set_analysis_day
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
      
    if params[:traningevent_id].present?
      @traning_analysis = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time)
      
      unless one_month.count <= @traning_analysis.count
        ActiveRecord::Base.transaction do
          one_month.each { |day| @user.traning_analysis.create!(start_time: day, traningevent_id: params[:traningevent_id]) }
        end
        @traning_analysis = @user.traning_analysis.where(start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time)
      end
    end
  end
  
  # トレーニング関連タブ
  def set_traning_tab
    @bodyparts = Bodypart.all
    @traningtypes = Traningtype.all
    @subbodypart_active = SubBodypart.where(bodypart_id: params[:bodypart_id]).order(:id).limit(1).pluck(:id).sum
    @subbodyparts = SubBodypart.where(bodypart_id: params[:bodypart_id])
    
    if params[:bodypart_id].present? && params[:subbodypart_id].present? && params[:traningtype_id].present?
      @traningevents = @user.traningevents.where(bodypart_id: params[:bodypart_id], traningtype_id: params[:traningtype_id], subbodypart_id: params[:subbodypart_id])
    elsif params[:bodypart_id].present? && params[:subbodypart_id].present?
      @traningevents = @user.traningevents.where(bodypart_id: params[:bodypart_id], subbodypart_id: params[:subbodypart_id])
    elsif params[:bodypart_id].present? && params[:traningtype_id].present?
      @traningevents = @user.traningevents.where(bodypart_id: params[:bodypart_id], traningtype_id: params[:traningtype_id])
    elsif params[:traningtype_id].present?
      @traningevents = @user.traningevents.where(traningtype_id: params[:traningtype_id])
    elsif params[:bodypart_id].present?
      @traningevents = @user.traningevents.where(bodypart_id: params[:bodypart_id])
    else
      @traningevents = @user.traningevents.all
    end
    
    @traningeventss = @bodyparts.pluck(:id).map{|bodypart|
      [bodypart, @user.traningevents.where(bodypart_id: bodypart).pluck(:id, :traning_name)]
    }
    @traning_analysis = @traningeventss.map{|bodypart, traningevents|
      traningevents.map{|id, name|
        [
          id, gon.day = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:start_time).map{|day| day.day}, gon.total = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:total_load), gon.max = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:max_load)
        ]
      }
    }
  end
    

  # TodayExeciseクラスの1ヶ月分start_time(日にち)を作成
  def today_exercise_set_one_month
    @user = current_user
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
    @exercises = @user.today_exercise.where(start_time: @first_day..@last_day).order(:start_time)
    
    unless one_month.count <= @exercises.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.today_exercise.create!(start_time: day) }
      end
      @today_exercises = @user.today_exercise.where(start_time: @first_day..@last_day).order(:start_time)
    end
  end
  
  # ========== 食事関連 ==========
  
  def set_nutritions
    @nutritions = [:calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt]
    @attribute_names = @nutritions.map{|nutrition| Myfood.human_attribute_name(nutrition)}
  end
  
  def set_myfood
    if params[:myfood_id].present?
      @myfood = @user.myfoods.find(params[:myfood_id]) 
    else
      @myfood = @user.myfoods.find(params[:id])
    end
  end
  
  def set_recipe
    @recipe = @user.recipes.find(params[:recipe_id]) if params[:recipe_id].present?
  end
  
  def set_recipefoods_total
    if params[:recipe_id].present?
      @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    else
      @recipefoods = @user.recipefoods.where(recipe_id: params[:id])
    end
    if params[:recipe_id].present? || params[:id].present?
      nutritions = [:calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt]
      @recipe_myfoods =  nutritions.map {|nutrition| @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(nutrition), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum}
    end
  end
  
  def set_meals
    @timezones = Timezone.all
    
    @todaymeals = @timezones.map{|timezone| @user.todaymeals.where(start_time: params[:start_time], timezone_id: timezone).pluck(:myfood_id)}
    @myfoods = @todaymeals.map{|todaymeal| @user.myfoods.where(id: todaymeal)}
    
    @todaymeal_recipes = @timezones.map{|timezone| @user.todaymeal_recipes.where(timezone_id: timezone).pluck(:recipe_id)}
    @recipes = @todaymeal_recipes.map{|todaymeal_recipe| @user.recipes.where(id: todaymeal_recipe).pluck(:calorie)}
  end
  
  def set_meals_analysis
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
      
      @meals_analysis = @user.meals_analysis.where( start_time: @first_day..@last_day).order(:start_time)
      gon.start_times = @meals_analysis.pluck(:start_time).map{|day| day.day}
      gon.calories = @meals_analysis.pluck(:calorie)
      gon.day_target_calorie = @day_target_calorie
      
      unless one_month.count <= @meals_analysis.count
        ActiveRecord::Base.transaction do
          one_month.each { |day| @user.meals_analysis.create!(start_time: day) }
        end
        @meals_analysis = @user.meals_analysis.where(start_time: @first_day..@last_day).order(:start_time)
      end
  end
  
end
