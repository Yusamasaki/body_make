class MyfoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  def index
    @myfoods = @user.myfoods.all
    
  end
  
  def new
    @myfood = @user.myfoods.new
  end
  
  def create
    @myfood = @user.myfoods.new(myfood_params)
    if @myfood.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, timezone: params[:timezone], start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_path(@user, timezone: params[:timezone], start_date: params[:start_date], start_time: params[:start_time])
    end
  end
  
  def show
    @myfood = @user.myfoods.find(params[:id])
  end
  
  def edit
    @myfood = @user.myfoods.find(params[:id])
  end
  
  def update
    @myfood = @user.myfoods.find(params[:id])
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
    @myfood = @user.myfoods.find(params[:id])
    @myfood.destroy
    flash[:success] = "削除しました。"
    redirect_to user_myfoods_url(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time]) 
      
  end
  
  private
  
    def myfood_params
      params.require(:myfood).permit(:food_name, :amount, :calorie, :protein, :fat, :carbo, :suger, :dietary_fiber, :salt)
    end
  
end
