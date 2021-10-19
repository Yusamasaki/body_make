class TodaymealsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create]
  before_action :set_basic, only: [:index]
  
  def index
    @timezones = Timezone.all
    @todaymeal = @timezones.map {|timezone| @user.todaymeals.where(timezone_id: timezone)}
    
  end
  
  def new
    @myfood = @user.myfoods.find(params[:myfood_id])
    @todaymeal = @user.todaymeals.new
  end
  
  def create
    @todaymeal = @user.todaymeals.new(todaymeal_params)
    
    @myfood = @user.myfoods.find(params[:timezone_id]) if params[:timezone_id].present?
    
    if @todaymeal.save!
      flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
      redirect_to user_myfoods_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to user_myfoods_path(@user, timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
    
  end
  
  def todaymeal_params
    params.require(:todaymeal).permit(:start_time, :myfood_id, :timezone_id)
  end
  
end
