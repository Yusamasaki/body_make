class TraningeventsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  before_action :traning_set, only: [:index, :new, :create, :edit, :update, :show]
  
  def index
    @traningevents_all = @user.traningevents.all
    @traningtypes = Traningtype.all
    @bodyparts = Bodypart.where(id: 2..6)
  end
  
  def new
    @bodypart = Bodypart.find(params[:bodypart_id])
    @traningtype = Traningtype.find(params[:traningtype_id])
    @sub_bodyparts = @bodypart.sub_bodyparts.all.map {|sub_bodypart| [sub_bodypart.sub_body_part, sub_bodypart.sub_body_part]}
    @traningevent = @user.traningevents.new
  end
  
  def create
    @traningevent = @user.traningevents.new(traningevent_params)
    if @traningevent.save
      redirect_to user_traningevents_path(current_user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_traningevent_path(current_user, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def edit
    @traningevent = @user.traningevents.find(params[:id])
    @body_part = Bodypart.find_by(body_part: @traningevent.body_part)
    @sub_bodyparts = @body_part.sub_bodyparts.all.map {|sub_bodypart| [sub_bodypart.sub_body_part, sub_bodypart.sub_body_part]}
  end

  def update
    @traningevent = @user.traningevents.find(params[:id])
    if @traningevent.update_attributes!(traningevent_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_traningevent_path(current_user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "更新に失敗しました"
      redirect_to user_traningevent_path(current_user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def show
    @traningevent = @user.traningevents.find(params[:id])
  end

  def destroy
    @traningevent = @user.traningevents.find(params[:id])
    @traningevent.destroy
    flash[:success] = "削除しました。"
    redirect_to user_traningevents_path(@user, start_date: params[:start_date], start_time: params[:start_time]) 
  end

  private
    def traningevent_params
      params.require(:traningevent).permit(:body_part, :sub_body_part, :traning_name, :traning_type)
    end
  
end
