class TraningeventsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  before_action :set_today_traning_day, only: [:edit, :update, :create]
  before_action :set_traningevent, only: [:edit, :update, :destroy, :index, :new]
  before_action :set_traningevent, only: [:show, :destroy]
  
  def index
    @traningevents_all = @user.traningevents.all
    @traningtypes = Traningtype.all
    @bodyparts = Bodypart.where(id: 2..6)
  end
  
  def new
    @traningtype = Traningtype.find(params[:traningtype_id])
    @traningevent = @user.traningevents.new
    @bodypart = Bodypart.find(params[:bodypart_id])
    @sub_bodyparts = @bodypart.sub_bodyparts.all.map {|sub_bodypart| [sub_bodypart.sub_body_part, sub_bodypart.sub_body_part]}
  end
  
  def create
    @traningevent = @user.traningevents.new(traningevent_params)
    if @traningevent.save
      redirect_to user_traningevents_path(@user, today_traning_day_id: @today_traning_day, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_traningevent_path(@user, today_traning_day_id: @today_traning_day, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def edit
    @body_part = Bodypart.find_by(body_part: @traningevent.body_part)
    @sub_bodyparts = @body_part.sub_bodyparts.all.map {|sub_bodypart| [sub_bodypart.sub_body_part, sub_bodypart.sub_body_part]}
  end

  def update
    if @traningevent.update_attributes!(traningevent_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_traningevent_path(@user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "更新に失敗しました"
      redirect_to user_traningevent_path(@user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def show
  end

  def destroy
    @traningevent.destroy
    flash[:success] = "削除しました。"
    redirect_to user_traningevents_path(@user, start_date: params[:start_date], start_time: params[:start_time]) 
  end

  private
  
    def traningevent_params
      params.require(:traningevent).permit(:body_part, :sub_body_part, :traning_name, :traning_type)
    end
  
end
