class RecipesController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_basic, only: []
  
  
  def index
  end
  
  def new
    @recipe = @user.recipes.new
  end
  
  def create
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save!
      flash[:success] = "#{@recipe.recipe_name}の登録に成功しました。"
      redirect_to user_recipefoods_path(@user, recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_recipes_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
  end
  
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :amount, :timezone_id)
  end
  
end
