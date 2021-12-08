class MealsAnalysisController < ApplicationController
  
  # before_action :logged_in_user, only: :index
  before_action :set_user, only: [:index]
  before_action :set_basic, only: [:index]
  before_action :set_bmr, only: [:index]
  before_action :set_meals_analysis, only: [:index]
  before_action :set_nutritions, only: [:index]
  
  def index
    if params[:timezone_id].present?
      timezones = Timezone.where(id: params[:timezone_id])
    else
      timezones = Timezone.all
    end
    
    @timezones = Timezone.all
    # 時間帯別の総摂取栄養素・摂取栄養素
    @timezone_meals = timezones.map {|timezone| 
      [
        timezone, @user.todaymeal_recipes.where(start_time: params[:start_time], timezone_id: timezone).pluck(:recipe_id, :amount), 
        @user.todaymeals.where(start_time: params[:start_time], timezone_id: timezone).pluck(:myfood_id, :amount)
      ]
    }.map {|timezone, recipe, myfood| 
      [
        timezone, recipe.map{|id, amount| [@user.recipes.where(id: id), amount]}, myfood.map{|id, amount| [@user.myfoods.where(id: id), amount]}
      ]
    }.map{|timezone, recipe, myfood|
      [
        timezone, @nutritions.map{|nutrition| 
          [recipe.map{|recipe, amount| recipe.pluck(nutrition).sum * amount}.sum, myfood.map{|myfood, amount| myfood.pluck(nutrition).sum * amount}.sum].sum
        }, myfood, recipe
      ]
    }
    
    @timezone_meal_total = @timezone_meals
    
    # 一日の総摂取栄養素
    todaymeals_start_time = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount)
    todaymeal_recipes_start_time = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount)
    
    @day_totalmeals = @nutritions.map {|nutrition|
      todaymeals_start_time.map {|myfood, amount|
        [@user.myfoods.where(id: myfood).pluck(nutrition).sum * amount].sum
      }.sum +
      todaymeal_recipes_start_time.map {|recipe, amount| 
        [@user.recipes.where(id: recipe).pluck(nutrition).sum * amount].sum
      }.sum
    }
    
    @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
    @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])
    if @todaymeals.present? || @todaymeal_recipes.present?
      gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
      calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
        (
          todaymeals_start_time.map {|myfood, amount|
            [@user.myfoods.where(id: myfood).pluck(nutrition).sum * amount].sum 
          }.sum +
          todaymeal_recipes_start_time.map {|recipe, amount| 
            [@user.recipes.where(id: recipe).pluck(nutrition).sum * amount].sum
          }.sum
        ) * ratio
      }
      gon.myfoods = calories.map{|calorie|
        ((calorie / calories.sum) * 100).floor(1)
      }
      gon.total_calorie = calories.sum
    end
  end
end
