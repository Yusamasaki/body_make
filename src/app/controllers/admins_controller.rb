class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @users = User.all.page(params[:page]).per(1).order(:id)
    @categories = ExerciseCategory.all.page(params[:page]).per(1).order(:id)
  end
end
