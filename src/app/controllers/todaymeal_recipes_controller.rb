class TodaymealRecipesController < ApplicationController
  
  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_recipe, only: [:new, :create, :edit, :update]
  before_action :ser_recipefoods_total, only: [:new, :edit, :update]
  before_action :set_nutritions, only: [:new, :edit]
  
  def new
    @todaymeal_recipe = @user.todaymeal_recipes.new
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @timezone = Timezone.find(params[:timezone_id])
  end
  
  def create
    @todaymeal_recipe = @user.todaymeal_recipes.new(todaymeal_recipe_params)
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @recipe_myfoods = @recipefoods.map {|recipefood| @user.myfoods.where(id: recipefood.myfood_id)}
    if @todaymeal_recipe.save!
      flash[:success] = "#{@recipe.recipe_name}の登録に成功しました。"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_recipes_path(@user, recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def edit
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id])
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @timezone = Timezone.find(params[:timezone_id])
  end
  
  def update
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id])
    
    ActiveRecord::Base.transaction do 
      @todaymeal_recipe.update_attributes!(todaymeal_recipe_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "更新に失敗しました"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def destroy
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id])
    @recipe = @user.recipes.find(@todaymeal_recipe.recipe_id)
    @todaymeal_recipe.destroy
    flash[:success] = "#{@recipe.recipe_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end
  
  private
  
    def todaymeal_recipe_params
      params.require(:todaymeal_recipe).permit(:start_time, :recipe_id, :timezone_id, :note, :amount)
    end
  
end
