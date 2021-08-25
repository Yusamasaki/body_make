class ApplicationController < ActionController::Base
  def set_user
    @user = User.find(params[:id])
  end
end
