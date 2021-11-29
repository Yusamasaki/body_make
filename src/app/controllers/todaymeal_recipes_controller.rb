class TodaymealRecipesController < ApplicationController
  
  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_basic, only: [:new, :edit]
  before_action :set_recipe, only: [:new, :create, :edit, :update]
  before_action :ser_recipefoods_total, only: [:new, :edit, :update]
  before_action :set_nutritions, only: [:new, :edit]
  
  def new
    @todaymeal_recipe = @user.todaymeal_recipes.new
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @timezones = Timezone.all
    @timezone = Timezone.find(params[:timezone_id])
    
    if @recipe.calorie.present?
      gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
        calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
          @user.recipes.where(id: params[:recipe_id]).pluck(nutrition).sum * ratio
        }
      gon.myfoods = calories.map{|calorie|
        ((calorie / calories.sum) * 100).floor(1)
      }
      gon.total_calorie = calories.sum
    end
  end
  
  def create
    @todaymeal_recipe = @user.todaymeal_recipes.new(todaymeal_recipe_params)
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @recipe_myfoods = @recipefoods.map {|recipefood| @user.myfoods.where(id: recipefood.myfood_id)}
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    @timezone = Timezone.find(params[:timezone_id])
    
    todaymeal_recipe_valid = @user.todaymeal_recipes.find_by(start_time: params[:start_time], timezone_id: params[:timezone_id], recipe_id: @recipe)
    if todaymeal_recipe_valid.nil?
      ActiveRecord::Base.transaction do 
        @todaymeal_recipe.save!
        
        # -------- @meals_analyのUpdate機能 --------
        
          @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
          @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])
          
            if @todaymeals.present?
              myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount| 
                          [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            if @todaymeal_recipes.present?
              recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount| 
                          [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            
            if @todaymeals.present? && @todaymeal_recipes.present?
              total = myfoods + recipes
            elsif @todaymeals.present? && @todaymeal_recipes.blank?
              total = myfoods
            elsif @todaymeal_recipes.present? && @todaymeals.blank?
              total = recipes
            else
              total = nil
            end
          
        @meals_analys.update_attributes!(calorie: total)
        
        # -------- @meals_analyのUpdate機能 --------

        flash[:success] = "#{@recipe.recipe_name}の登録に成功しました。"
        redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
      rescue ActiveRecord::RecordInvalid
        flash[:danger] = "登録に失敗しました。"
        redirect_to new_user_todaymeal_recipe_path(@user, switching: "record", recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      flash[:danger] = "登録に失敗しました。#{params[:start_time]}の#{@timezone.time_zone}には#{@recipe.recipe_name}は登録してあります。分量などで調整下さい。"
        redirect_to new_user_todaymeal_recipe_path(@user, switching: "record", recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def edit
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id])
    @recipefoods = @user.recipefoods.where(recipe_id: params[:recipe_id])
    @timezones = Timezone.all
    @timezone = Timezone.find(params[:timezone_id])
    
    if @recipe.calorie.present?
      gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
        calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
          @user.recipes.where(id: params[:recipe_id]).pluck(nutrition).sum * ratio
        }
      gon.myfoods = calories.map{|calorie|
        ((calorie / calories.sum) * 100).floor(1)
      }
      gon.total_calorie = calories.sum
    end
  end
  
  def update
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id])
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    
    ActiveRecord::Base.transaction do 
      @todaymeal_recipe.update_attributes!(todaymeal_recipe_params)
      
        # -------- @meals_analyのUpdate機能 --------
        
          @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
          @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])
          
            if @todaymeals.present?
              myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount| 
                          [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            if @todaymeal_recipes.present?
              recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount| 
                          [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            
            if @todaymeals.present? && @todaymeal_recipes.present?
              total = myfoods + recipes
            elsif @todaymeals.present? && @todaymeal_recipes.blank?
              total = myfoods
            elsif @todaymeal_recipes.present? && @todaymeals.blank?
              total = recipes
            else
              total = nil
            end
          
        @meals_analys.update_attributes!(calorie: total)
        
        # -------- @meals_analyのUpdate機能 --------
      
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
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    
    @todaymeal_recipe.destroy
    
      # -------- @meals_analyのUpdate機能 --------
        
          @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
          @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])
          
            if @todaymeals.present?
              myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount| 
                          [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            if @todaymeal_recipes.present?
              recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount| 
                          [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            
            if @todaymeals.present? && @todaymeal_recipes.present?
              total = myfoods + recipes
            elsif @todaymeals.present? && @todaymeal_recipes.blank?
              total = myfoods
            elsif @todaymeal_recipes.present? && @todaymeals.blank?
              total = recipes
            else
              total = nil
            end
          
        @meals_analys.update_attributes!(calorie: total)
        
        # -------- @meals_analyのUpdate機能 --------
    
    flash[:success] = "#{@recipe.recipe_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end
  
  private
  
    def todaymeal_recipe_params
      params.require(:todaymeal_recipe).permit(:start_time, :recipe_id, :timezone_id, :note, :amount)
    end
  
end
