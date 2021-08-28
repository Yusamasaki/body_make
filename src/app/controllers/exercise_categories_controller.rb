class ExerciseCategoriesController < ApplicationController
  # before_action あとで管理者のみ編集可能を設置
  before_action :set_category, only: %i(edit update destroy)

  def index
    @categories = ExerciseCategory.all.order(:id)
  end

  def new
    @category = ExerciseCategory.new
  end

  def create
    @category = ExerciseCategory.new(category_params)
    if @category.save
      redirect_to exercise_categories_url, flash: { success: "「#{@category.name}」を登録しました。" }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to exercise_categories_url, flash: { success: "「#{@category.name}」を更新しました。" }
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to exercise_categories_url, flash: { danger: "「#{@category.name}」を削除しました。"}
  end

  private
    def set_category
      @category = ExerciseCategory.find(params[:id])
    end

    def category_params
      params.require(:exercise_category).permit(:name)
    end

    def content_params
      params.require(:exercise_content).permit(exercise_content:[:content, :calorie])
    end  
end
