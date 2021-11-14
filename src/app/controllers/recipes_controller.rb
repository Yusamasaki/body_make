class RecipesController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_basic, only: [:index]
  
  def index
    @recipes = @user.recipes.all.order(:id).page(params[:page])
    
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
    @recipe = @user.recipes.find(params[:id])
  end
  
  def update
    @recipe = @user.recipes.find(params[:id])
    ActiveRecord::Base.transaction do
      @recipe.update_attributes!(recipe_params)
      flash[:success] = "#{@recipe.recipe_name}の更新に成功しました。"
      if params[:before] == "new"
        redirect_to new_user_todaymeal_recipe_path(@user, todaymeal_recipe_id:  params[:todaymeal_recipe_id], before: params[:action], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      elsif params[:before] == "edit"
        redirect_to edit_user_todaymeal_recipe_path(@user, params[:todaymeal_recipe_id], before: params[:action], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "変更に失敗しました。"
      redirect_to edit_user_recipe_path(@user, @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
  end
  
  def destroy
    @recipe = @user.recipes.find(params[:id])
    @recipe.destroy
    flash[:success] = "#{@recipe.recipe_name}を削除しました。"
    redirect_to user_recipes_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:recipe_name)
    end
  
end
