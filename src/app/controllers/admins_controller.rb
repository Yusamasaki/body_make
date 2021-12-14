class AdminsController < ApplicationController
  # before_action :logged_in_user, only: :show
  before_action :authenticate_admin!, only: :show

  def show
    @users = User.all.page(params[:user_page]).per(5).order(:id)
    @categories = ExerciseCategory.all.page(params[:category_page]).per(3).order(:id)
  end
end
