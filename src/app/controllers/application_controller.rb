class ApplicationController < ActionController::Base
  def set_user
    @user = User.find(current_user.id)
  end
end
