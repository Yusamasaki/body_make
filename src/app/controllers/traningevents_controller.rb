class TraningeventsController < ApplicationController
  
  before_action :set_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_traningevent, only: [:edit, :update, :destroy]
  before_action :set_traning_tab, only: [:new, :create, :edit, :update]
  
  def new
    @traningevent = @user.traningevents.new
  end
  
  def create
    @traningevent = @user.traningevents.new(traningevent_params)
    if @traningevent.save
      flash[:success] = "#{@traningevent.traning_name}の登録に成功しました。"
      redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: @traningevent, bodypart_id: params[:bodypart_id], subbodypart_id: params[:subbodypart_id], traningtype_id: params[:traningtype_id], start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @traningevent.update_attributes(traningevent_params)
      flash[:success] = "更新に成功しました"
      redirect_to user_today_tranings_traning_new_path(@user, bodypart_id: @traningevent.bodypart_id, subbodypart_id: @traningevent.subbodypart_id, traningtype_id: @traningevent.traningtype_id, traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'edit'
    end
  end

  def destroy
    @traningevent.destroy
    flash[:success] = "削除しました。"
    redirect_to user_traningevents_url(@user, start_date: params[:start_date], start_time: params[:start_time]) 
  end

  private
  
    def traningevent_params
      params.require(:traningevent).permit(:traning_name, :bodypart_id, :subbodypart_id, :traningtype_id)
    end
  
end
