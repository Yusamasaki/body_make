class ExerciseCategoriesController < ApplicationController
  before_action :authenticate_admin!
  
  before_action :set_category, only: %i(edit update destroy)

  def index
    @categories = ExerciseCategory.all.page(params[:page]).per(2).order(:id)
  end

  def new
    @category = ExerciseCategory.new
    @category.exercise_contents.build
  end

  def create
    @category = ExerciseCategory.new(category_params)
    if @category.save
      redirect_to admin_url(current_admin), flash: { success: "カテゴリー「#{@category.name}」を登録しました。" }
    else
      redirect_to admin_url(current_admin)
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_url(current_admin), flash: { success: "カテゴリー「#{@category.name}」を更新しました。" }
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

    # exercise_contents_attributes: [:id ...] ここに:idを渡してないとupdateした時、コンテンツ情報が新たに重複登録されてしまう。
    def category_params
      params.require(:exercise_category).permit(:name, exercise_contents_attributes: [:id, :content, :mets, :exercise_category_id, :_destroy])
    end

    def content_params
      params.require(:exercise_content).permit(exercise_content:[:content, :mets])
    end
end
