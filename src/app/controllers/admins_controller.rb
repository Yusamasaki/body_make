class AdminsController < ApplicationController
  # before_action :logged_in_user, only: :show
  before_action :authenticate_admin!, only: :show

  def show
    @users = User.all.page(params[:page]).per(1).order(:id)
    @categories = ExerciseCategory.all.page(params[:page]).per(1).order(:id)
  end
end
