class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @timezones = Timezone.all
    if params[:search].present?
      @recipes = @user.recipes.search_recipe(params[:search])
    else
      @recipes = @user.recipes.search_recipe(params[:search]).page(params[:page])
    end
  end

  def new
    @timezones = Timezone.all
    @recipe = @user.recipes.new
  end

  def create
    @recipe = @user.recipes.new(recipe_params)
    if @recipe.save
      flash[:success] = "#{@recipe.recipe_name}の登録に成功しました。"
      redirect_to user_recipes_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'new'
    end
  end

  def edit
    @recipe = @user.recipes.find(params[:id])
  end

  def update
    @recipe = @user.recipes.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:success] = "#{@recipe.recipe_name}の更新に成功しました。"
      if params[:before] == "new"
        redirect_to new_user_todaymeal_recipe_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      elsif params[:before] == "edit"
        redirect_to edit_user_todaymeal_recipe_path(@user, params[:todaymeal_recipe_id], before: params[:before], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = @user.recipes.find(params[:id])
    @recipe.destroy
    flash[:success] = "#{@recipe.recipe_name}を削除しました。"
    if params[:before] == "edit"
      redirect_to user_todaymeals_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      redirect_to user_recipes_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name)
  end
end
