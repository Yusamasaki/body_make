class ApplicationController < ActionController::Base
  
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
  
  def date_set
    @date = params[:start_time], params[:start_date]
  end
end
