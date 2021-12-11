class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @categories = ExerciseCategory.all.page(params[:page]).per(5).order(:id)
  end
end
