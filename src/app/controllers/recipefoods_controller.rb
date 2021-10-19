class RecipefoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  
  def index
    @recipe = @user.recipes.find(params[:recipe_id])
    @todaymeal_recipe = @user.todaymeal_recipes.new
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @recipe_myfoods = @recipefoods.map {|recipefood| @user.myfoods.where(id: recipefood.myfood_id).pluck(:calorie)}
    
  end
  
  def new
    @recipe = @user.recipes.find(params[:recipe_id])
    @myfood = @user.myfoods.find(params[:myfood_id])
    @recipefood = @user.recipefoods.new
  end
  
  def create
    @recipe = @user.recipes.find(params[:recipe_id])
    @myfood = @user.myfoods.find(params[:myfood_id])
    @recipefood = @user.recipefoods.new(recipefood_params)
    
    ActiveRecord::Base.transaction do
    @recipefood.save!
      
      @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
      @recipe_calorie = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:calorie), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_protein = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:protein), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_fat = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:fat), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_carbo = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:carbo), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_sugar = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:sugar), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_dietary_fiber = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:dietary_fiber), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_salt = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:salt), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      
      @recipe.update_attributes!(calorie: @recipe_calorie, protein: @recipe_protein, fat: @recipe_fat, carbo: @recipe_carbo,
                                 sugar: @recipe_sugar, dietary_fiber: @recipe_dietary_fiber, salt: @recipe_salt)
      
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_recipefoods_path(@user, recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_recipefood_path(@user, myfood_id: @myfood, recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def destroy
    @recipe = @user.recipes.find(params[:recipe_id])
    @recipefood = @user.recipefoods.find(params[:id])
    @myfood = @user.myfoods.find(@recipefood.myfood_id)
    @recipefood.destroy
    
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
      @recipe_calorie = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:calorie), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_protein = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:protein), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_fat = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:fat), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_carbo = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:carbo), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_sugar = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:sugar), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_dietary_fiber = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:dietary_fiber), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      @recipe_salt = @recipefoods.map {|recipefood| [@user.myfoods.where(id: recipefood.myfood_id).pluck(:salt), @user.recipefoods.where(id: recipefood).pluck(:amount)].sum.inject(:*)}.sum
      
      @recipe.update_attributes!(calorie: @recipe_calorie, protein: @recipe_protein, fat: @recipe_fat, carbo: @recipe_carbo,
                                 sugar: @recipe_sugar, dietary_fiber: @recipe_dietary_fiber, salt: @recipe_salt)
    
    flash[:success] = "#{@myfood.food_name}を削除しました。"
    redirect_to user_recipefoods_path(@user, recipe_id: @recipefood.recipe_id, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
  end
  
  def recipefood_params
    params.require(:recipefood).permit(:myfood_id, :recipe_id, :amount)
  end
  
end
