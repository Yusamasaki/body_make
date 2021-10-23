class TodaymealsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :destroy]
  before_action :set_basic, only: [:index]
  before_action :set_myfood, only: [:new]
  before_action :set_meals, only: [:index]
  
  def index
    @timezones = Timezone.all
    
    @timezone_todaymeals = @timezones.map {|timezone| [ timezone, @user.todaymeal_recipes.where(start_time: params[:start_time], timezone_id: timezone).pluck(:recipe_id), @user.todaymeals.where(start_time: params[:start_time], timezone_id: timezone).pluck(:myfood_id) ] }
    
    @timezone_meal_total = @timezone_todaymeals.map {|timezone, recipe, myfood| [timezone, @user.recipes.where(id: recipe), @user.myfoods.where(id: myfood)]}
    
    @todaymeals_start_time = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id)
    @todaymeal_recipes_start_time = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id)
    
    @total_calorie = @todaymeals_start_time.map {|myfood| @user.myfoods.where(id: myfood).pluck(:calorie).sum}.sum +
                     @todaymeal_recipes_start_time.map {|recipe| @user.recipes.where(id: recipe).pluck(:calorie).sum}.sum
    
    @total_protein = @todaymeals_start_time.map {|myfood| @user.myfoods.where(id: myfood).pluck(:protein).sum}.sum +
                     @todaymeal_recipes_start_time.map {|recipe| @user.recipes.where(id: recipe).pluck(:protein).sum}.sum
                     
    @total_fat = @todaymeals_start_time.map {|myfood| @user.myfoods.where(id: myfood).pluck(:fat).sum}.sum +
                     @todaymeal_recipes_start_time.map {|recipe| @user.recipes.where(id: recipe).pluck(:fat).sum}.sum
                     
    @total_carbo = @todaymeals_start_time.map {|myfood| @user.myfoods.where(id: myfood).pluck(:carbo).sum}.sum +
                     @todaymeal_recipes_start_time.map {|recipe| @user.recipes.where(id: recipe).pluck(:carbo ).sum}.sum
                     
  end
  
  def new
    @todaymeal = @user.todaymeals.new
  end
  
  def create
    @todaymeal = @user.todaymeals.new(todaymeal_params)
    
    @myfood = @user.myfoods.find(params[:timezone_id]) if params[:timezone_id].present?
    
    if @todaymeal.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
    
  end
  
  def destroy
    @todaymeal = @user.todaymeals.find(params[:id])
    @myfood = @user.myfoods.find(@todaymeal.myfood_id)
    @todaymeal.destroy
    flash[:success] = "#{@myfood.food_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end
  
  private
  
    def todaymeal_params
      params.require(:todaymeal).permit(:start_time, :myfood_id, :timezone_id)
    end
  
end
