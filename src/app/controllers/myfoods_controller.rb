class MyfoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_basic, only: [:index]
  before_action :set_myfood, only: [:show, :edit, :update, :destroy]
  before_action :set_recipe, only: [:index]
  before_action :ser_recipefoods_total, only: [:index]
  
  def index
    @myfoods = @user.myfoods.all
  end
  
  def new
    @myfood = @user.myfoods.new
  end
  
  def create
    @myfood = @user.myfoods.new(myfood_params)
    ActiveRecord::Base.transaction do @myfood.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, timezone: params[:timezone], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_path(@user, timezone: params[:timezone], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
    gon.nutrition = [@myfood.protein, @myfood.fat, @myfood.carbo, @myfood.sugar, @myfood.dietary_fiber, @myfood.salt]
  end
  
  def edit
  end
  
  def update
    ActiveRecord::Base.transaction do
      @myfood.update_attributes!(myfood_params)
        flash[:success] = "更新に成功しました"
        redirect_to user_myfood_path(@user, @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
        flash[:danger] = "更新に失敗しました"
        redirect_to user_myfood_path(@user, @myfood, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
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
