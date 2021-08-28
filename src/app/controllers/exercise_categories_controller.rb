class ExerciseCategoriesController < ApplicationController
  def index
    @categories = ExerciseCategory.all
  end

  def new
    @category = ExerciseCategory.new
  end

  def create
    @category = ExerciseCategory.new(category_params)
    if @category.save
      flash[:success] = "「#{@category.name}」を登録しました。"
      redirect_to exercise_categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:exercise_category).permit(:name)
  end

  def content_params
    params.require(:exercise_content).permit(exercise_content:[:content, :calorie])
  end  
end
