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
    @user = User.find(current_user.id)
  end
  
  # ログイン済みのユーザーか確認します。
  def logged_in_user
    unless user_signed_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
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
    @bmr = @user.bmr unless params[:recipe_id].present?
    @target_weight = @user.targetweight unless params[:recipe_id].present?
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
    

  # TodayExeciseクラスの1ヶ月分start_time(日にち)を作成
  def today_exercise_set_one_month
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
    
    @today_exercises = current_user.today_exercise.where( start_time: @first_day..@last_day).order(:start_time)
    
    unless one_month.count == @today_exercises.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| current_user.today_exercise.create!(start_time: day) }
      end
      @today_exercises = current_user.today_exercise.where(start_time: @first_day..@last_day).order(:start_time)
    end
  end
  
  # 食事関連
  
  def set_myfood
    @myfood = @user.myfoods.find(params[:myfood_id]) if params[:myfood_id].present?
    @myfood = @user.myfoods.find(params[:id]) if params[:id].present?
  end
  
  def set_recipe
    @recipe = @user.recipes.find(params[:recipe_id]) if params[:recipe_id].present?
    @recipe = @user.recipes.find(params[:id]) if params[:id].present?
  end
  
  def ser_recipefoods_total
    if params[:recipe_id].present?
      @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
      
      @recipe_calorie = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:calorie), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_protein = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:protein), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_fat = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:fat), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_carbo = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:carbo), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_sugar = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:sugar), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_dietary_fiber = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:dietary_fiber), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_salt = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:salt), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
    end
  end
  
  def set_meals
    @timezones = Timezone.all
    
    @todaymeals = @timezones.map{|timezone| @user.todaymeals.where(timezone_id: timezone).pluck(:myfood_id)}
    @myfoods = @todaymeals.map{|todaymeal| @user.myfoods.where(id: todaymeal)}
    
    @todaymeal_recipes = @timezones.map{|timezone| @user.todaymeal_recipes.where(timezone_id: timezone).pluck(:recipe_id)}
    @recipes = @todaymeal_recipes.map{|todaymeal_recipe| @user.recipes.where(id: todaymeal_recipe).pluck(:calorie)}
    
  end
end
