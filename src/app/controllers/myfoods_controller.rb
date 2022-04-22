class MyfoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy, :api_new, :api_create, :import]
  before_action :set_myfood, only: [:update, :destroy]
  before_action :set_recipe, only: [:index]
  before_action :set_recipefoods_total, only: [:index]
  before_action :set_nutritions, only: [:index]

  def index
    @timezones = Timezone.all
    if params[:search].present?
      @myfoods = @user.myfoods.search_food(params[:search])
    else
      @myfoods = @user.myfoods.search_food(params[:search]).page(params[:page])
    end
  end

  def show
  end

  def new
    @timezones = Timezone.all
    @myfood = @user.myfoods.new
  end

  def create
    @myfood = @user.myfoods.new(myfood_params)
    if @myfood.save
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'new'
    end
  end

  def edit
    @myfood = @user.myfoods.find(params[:id])
  end

  def update
    @myfood = @user.myfoods.find(params[:id])
    if @myfood.update_attributes(myfood_params)
      flash[:success] = "更新に成功しました"
      redirect_to new_user_todaymeal_path(@user, switching: "record", myfood_id: @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'edit'
    end
  end

  def destroy
    @myfood.destroy
    flash[:success] = "#{@myfood.food_name}を削除しました。"
    redirect_to user_myfoods_url(@user, recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
  end

  def api_new
    @myfood = @user.myfoods.new
    @apifoods = [:calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt].map{|nutrition|
      params[nutrition]
    }
  end

  def api_create
    @apifoods = [:calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt].map{|nutrition|
      params[nutrition]
    }
    @myfood = @user.myfoods.new(food_name: params[:food_name], calorie: params[:calorie], protein: params[:protein],
                                fat: params[:fat], carbo: params[:carbo], sugar: params[:sugar], dietary_fiber: params[:dietary_fiber], salt: params[:salt])
    if @myfood.save
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: 1, start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'api_new'
    end
  end

  def import
    if params[:file].present? && params[:file].original_filename && File.extname(params[:file].original_filename) == ".csv"
      cnt = @user.myfoods.import(params[:file])
      unless cnt == 0
        flash[:success] = "#{cnt}件の登録に成功しました。"
        redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: 1, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録件数は０件です"
        redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: 1, start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_path(@user, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: 1, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  private

  def myfood_params
    params.require(:myfood).permit(:food_name, :amount, :calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt)
  end
end
