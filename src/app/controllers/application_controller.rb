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
  
  def set_basic
    @bmr = @user.bmr
    @target_weight = @user.targetweight
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
    
end
