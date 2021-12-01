class MyfoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy, :api_new, :api_create]
  before_action :set_basic, only: [:index, :new, :edit, :api_new]
  before_action :set_myfood, only: [:show, :update, :destroy]
  before_action :set_recipe, only: [:index]
  before_action :ser_recipefoods_total, only: [:index]
  before_action :set_nutritions, only: [:index]
  
  def index
    @timezones = Timezone.all
    if params[:search].present?
      @myfoods = @user.myfoods.search_food(params[:search])
    else
      @myfoods = @user.myfoods.search_food(params[:search]).page(params[:page])
    end
  end
  
  def new
    @timezones = Timezone.all
    @myfood = @user.myfoods.new
  end
  
  def create
    @myfood = @user.myfoods.new(myfood_params)
    ActiveRecord::Base.transaction do 
      @myfood.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_myfood_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
    gon.nutrition = [@myfood.protein, @myfood.fat, @myfood.carbo, @myfood.sugar, @myfood.dietary_fiber, @myfood.salt]
  end
  
  def edit
    @myfood = @user.myfoods.find(params[:id])
  end
  
  def update
    @myfood = @user.myfoods.find(params[:id])
    ActiveRecord::Base.transaction do
      @myfood.update_attributes!(myfood_params)
        flash[:success] = "更新に成功しました"
        redirect_to new_user_todaymeal_path(@user, switching: "record", myfood_id: @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
        flash[:danger] = "更新に失敗しました"
        redirect_to edit_user_myfood_path(@user, @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def destroy
    @myfood.destroy
    flash[:success] = "削除しました。"
    redirect_to user_myfoods_url(@user, recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time]) 
  end
  
  def api_new
    @apifoods = [:calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt].map{|nutrition|
      params[nutrition]
    }
  end
  
  def api_create
    @myfood = @user.myfoods.new(food_name: params[:food_name], calorie: params[:calorie], protein: params[:protein],
                                fat: params[:fat], carbo: params[:carbo], sugar: params[:sugar], dietary_fiber: params[:dietary_fiber], salt: params[:salt])
    ActiveRecord::Base.transaction do 
      @myfood.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: 1, start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_api_new_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], 
                                            food_name: params[:food_name], calorie: params[:calorie], protein: params[:protein], fat: params[:fat], carbo: params[:carbo],
                                            dietary_fiber: params[:dietary_fiber], sugar: params[:sugar], salt: params[:salt], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  private
  
    def myfood_params
      params.require(:myfood).permit(:food_name, :amount, :calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt)
    end
  
end
