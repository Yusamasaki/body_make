class ApplicationController < ActionController::Base
  def set_user
    @user = User.current_user.id
  end
end
