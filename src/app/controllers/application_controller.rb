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
  
  
  
  # BodyWeightクラスの1ヶ月分start_time(日にち)を作成
  def bodyweight_set_one_month
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    one_month = [*@first_day..@last_day]
    
    @bodyweights = current_user.bodyweights.where( start_time: @first_day..@last_day).order(:start_time)
    
    unless one_month.count == @bodyweights.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| current_user.bodyweights.create!(start_time: day) }
      end
      @bodyweights = current_user.bodyweights.where(start_time: @first_day..@last_day).order(:start_time)
    end
  end
  
  def traning_set
    @bodypart = Bodypart.all
    @bodypart.each do |bodypart|
      @sub_bodypart = bodypart.sub_bodyparts.all
    end
    @traningtypes = Traningtype.all
  end
end
