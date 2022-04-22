class RecipefoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create, :destroy]
  before_action :set_nutritions, only: [:new, :create]

  def new
    @recipefood = @user.recipefoods.new
    @recipe = @user.recipes.find(params[:recipe_id])
    @myfood = @user.myfoods.find(params[:myfood_id])

    gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
      calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
        @user.myfoods.where(id: params[:myfood_id]).pluck(nutrition).sum * ratio
      }
    gon.myfoods = calories.map{|calorie|
      ((calorie / calories.sum) * 100).floor(1)
    }
    gon.total_calorie = calories.sum
  end

  def create
    @recipefood = @user.recipefoods.new(recipefood_params)
    @myfood = @user.myfoods.find(params[:myfood_id])
    @recipe = @user.recipes.find(params[:recipe_id])

    recipefood_valid = @user.recipefoods.find_by(myfood_id: @myfood, recipe_id: @recipe)

    if recipefood_valid.nil?
      if @recipefood.save
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

        if params[:before] == "new"
          redirect_to new_user_todaymeal_recipe_path(@user, switching: "record", before: params[:before], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
        elsif params[:before] == "edit"
          redirect_to edit_user_todaymeal_recipe_path(@user, params[:todaymeal_recipe_id], switching: "record", before: params[:before], recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
        end
      else
        render 'new'
      end
    else
      flash[:danger] = "登録に失敗しました。#{@recipe.recipe_name}には#{@myfood.food_name}は登録してあります。分量などで調整下さい"
      redirect_to new_user_recipefood_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], switching: "record", before: params[:before], myfood_id: @myfood, recipe_id: @recipe, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def destroy
    @recipefood = @user.recipefoods.find(params[:id])
    @myfood = @user.myfoods.find(@recipefood.myfood_id)
    @recipe = @user.recipes.find(params[:recipe_id])

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
    if params[:before] == "new"
      redirect_to new_user_todaymeal_recipe_path(@user, switching: "record", before: params[:action], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    elsif params[:before] == "edit"
      redirect_to edit_user_todaymeal_recipe_path(@user, params[:todaymeal_recipe_id], switching: "record", before: params[:action], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  private

  def recipefood_params
    params.require(:recipefood).permit(:myfood_id, :recipe_id, :amount)
  end
end
