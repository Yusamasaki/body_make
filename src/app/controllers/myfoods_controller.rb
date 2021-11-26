class MyfoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_basic, only: [:index, :new]
  before_action :set_myfood, only: [:show, :update, :destroy]
  before_action :set_recipe, only: [:index]
  before_action :ser_recipefoods_total, only: [:index]
  before_action :set_nutritions, only: [:index]
  
  def index
    @timezones = Timezone.all
    @q = @user.myfoods.ransack(params[:q], start_time: params[:start_time])
    @myfoods = @q.result(distinct: true).order(:id).page(params[:page])
    @todaymeal_recipe = @user.todaymeal_recipes.find(params[:id]) if params[:id].present?
    
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
      redirect_to user_myfoods_path(@user, id: params[:id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_myfood_path(@user, id: params[:id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
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
        redirect_to new_user_recipefood_path(@user, id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], myfood_id: @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
        flash[:danger] = "更新に失敗しました"
        redirect_to edit_user_myfood_path(@user, @myfood, todaymeal_recipe_id: params[:todaymeal_recipe_id], before: params[:before], recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def destroy
    @myfood.destroy
    flash[:success] = "削除しました。"
    redirect_to user_myfoods_url(@user, recipe_id: params[:recipe_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time]) 
      
  end
  
  private
  
    def myfood_params
      params.require(:myfood).permit(:food_name, :amount, :calorie, :protein, :fat, :carbo, :sugar, :dietary_fiber, :salt)
    end
  
end
