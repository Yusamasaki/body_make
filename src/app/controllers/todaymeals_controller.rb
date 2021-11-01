class TodaymealsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy, :analysis]
  before_action :set_basic, only: [:index, :analysis]
  before_action :set_myfood, only: [:new, :edit, :update]
  before_action :set_meals, only: [:index, :edit, :update]
  before_action :set_nutritions, only: [:index, :new, :edit, :update]
  before_action :ser_meals_analysis, only: [:index, :analysis]
  
  def index
    
    @timezones = Timezone.all
    
    # 時間帯別の総摂取栄養素・摂取栄養素
    @timezone_meals = @timezones.map {|timezone| 
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
    
  end
  
  def new
    @todaymeal = @user.todaymeals.new
    @timezone = Timezone.find(params[:timezone_id])
  end
  
  def create
    @todaymeal = @user.todaymeals.new(todaymeal_params)
    @myfood = @user.myfoods.find(params[:timezone_id]) if params[:timezone_id].present?
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    @timezone = Timezone.find(params[:timezone_id])
    
    todaymeal_valid = @user.todaymeals.find_by(start_time: params[:start_time], timezone_id: params[:timezone_id], myfood_id: @myfood)
    if todaymeal_valid.nil?
      if @todaymeal.save!
        # セーブ後のmyfoodsとrecipesのcalorieを全検索してsumで全て足す
        myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{|today|
          @user.myfoods.where(id: today).pluck(:calorie).sum
        }.sum
        recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id).map{|today_recipe| 
          @user.recipes.where(id: today_recipe).pluck(:calorie).sum
        }.sum
        # 上記で算出したmyfoodsとrecipeのcalorieを足し算
        total = myfoods + recipes
        # 上記で算出したtotalを@meals_analysのcalorieにupdate
        @meals_analys.update_attributes!(calorie: total)
        
        flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
        redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録に失敗しました。"
        redirect_to new_user_todaymeal_path(@user, myfood_id: params[:myfood_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      flash[:danger] = "登録に失敗しました。#{params[:start_time]}の#{@timezone.time_zone}には#{@myfood.food_name}は登録してあります。分量などで調整下さい。"
      redirect_to new_user_todaymeal_path(@user, myfood_id: params[:myfood_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def edit
    @todaymeal = @user.todaymeals.find(params[:id])
  end
  
  def update
    @todaymeal = @user.todaymeals.find(params[:id])
    
    ActiveRecord::Base.transaction do 
      @todaymeal.update_attributes!(todaymeal_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "更新に失敗しました"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def destroy
    @todaymeal = @user.todaymeals.find(params[:id])
    @myfood = @user.myfoods.find(@todaymeal.myfood_id)
    @todaymeal.destroy
    flash[:success] = "#{@myfood.food_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end
  
  def analysis
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    
    gon.one_month = [*@first_day..@last_day]
    
    gon.meals = gon.one_month.map {|day|
                  [@user.todaymeals.where(start_time: day).pluck(:myfood_id), @user.todaymeal_recipes.where(start_time: day).pluck(:recipe_id)]
                }.map{|myfood, recipe|
                  [@user.myfoods.where(id: myfood).pluck(:calorie).sum, @user.recipes.where(id: recipe).pluck(:calorie).sum].sum
                }
                # debugger
  end
  
  private
  
    def todaymeal_params
      params.require(:todaymeal).permit(:start_time, :myfood_id, :timezone_id, :amount, :note)
    end
  
end
