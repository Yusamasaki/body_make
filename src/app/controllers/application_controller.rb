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
  
  # ---------トレーニング関連---------
  
  def set_today_traning_day
    @today_traning_day = @user.today_traning_days.find(params[:today_traning_day_id])
  end
  
  def set_traningevent
    @traningevent = @user.traningevents.find(params[:id])
  end
  
  def set_today_traning
    @today_traning = @user.today_tranings.find(params[:id])
  end
    
end
