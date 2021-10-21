class RecipesController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_basic, only: [:index]
  before_action :set_recipe, only: [:edit, :update, :destroy]
  
  def index
    @recipes = @user.recipes.all.order(:id)
    
  end
  
  def new
    @recipe = @user.recipes.new
  end
  
  def create
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save!
      flash[:success] = "#{@recipe.recipe_name}の登録に成功しました。"
      redirect_to user_recipes_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_recipe_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def edit
  end
  
  def update
    ActiveRecord::Base.transaction do
      @recipe.update_attributes!(recipe_params)
      flash[:success] = "#{@recipe.recipe_name}の更新に成功しました。"
      redirect_to user_recipefoods_path(@user, recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "変更に失敗しました。"
      redirect_to edit_user_recipe_path(@user, @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "#{@recipe.recipe_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:recipe_name)
    end
  
end
