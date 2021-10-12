class TraningeventsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  before_action :set_basic, only: [:index]
  before_action :set_traningevent, only: [:edit, :update, :destroy, :show]
  
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
    @bodypart = Bodypart.find(params[:bodypart_id])
    @traningtype = Traningtype.find(params[:traningtype_id])
    @traningevent = @user.traningevents.new(traningevent_params)
    if @traningevent.save
      flash[:success] = "#{@traningevent.traning_name}の登録に成功しました。"
      redirect_to user_traningevents_path(@user, bodypart_id: @bodypart, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_traningevent_path(@user, bodypart_id: @bodypart, traningtype_id: @traningtype, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def edit
    @body_part = Bodypart.find_by(body_part: @traningevent.body_part)
    @sub_bodyparts = @body_part.sub_bodyparts.all.map {|sub_bodypart| [sub_bodypart.sub_body_part, sub_bodypart.sub_body_part]}
  end

  def update
    ActiveRecord::Base.transaction do
      @traningevent.update_attributes!(traningevent_params)
        flash[:success] = "更新に成功しました"
        redirect_to user_traningevent_path(@user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
        flash[:danger] = "更新に失敗しました"
        redirect_to edit_user_traningevent_path(@user, @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def show
    @bodypart = Bodypart.find(@traningevent.bodypart_id)
  end

  def destroy
    @traningevent.destroy
    flash[:success] = "削除しました。"
    redirect_to user_traningevents_url(@user, start_date: params[:start_date], start_time: params[:start_time]) 
  end

  private
  
    def traningevent_params
      params.require(:traningevent).permit(:sub_body_part, :traning_name, :bodypart_id, :traningtype_id)
    end
  
end
