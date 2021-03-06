# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    admin_path(current_admin)
  end
  
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # GET /resource/sign_in
  def new
    if user_signed_in?
      flash[:danger] = "編集権限がありません。"
      redirect_to user_path(current_user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      super
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
