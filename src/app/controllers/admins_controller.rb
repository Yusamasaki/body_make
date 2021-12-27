class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: :show

  def show
    @users = User.all.page(params[:user_page]).per(5).order(:id)
    @categories = ExerciseCategory.all.page(params[:category_page]).per(5).order(:id)
  end
end
