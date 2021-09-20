class PfcRatiosController < ApplicationController

  before_action :set_user, only: [:new, :create, :edit, :update]

  def new
    @pfc = PfcRatio.new
  end

  def create
    @pfc = pfc_ratio.new(pfc_params)
    if @pfc.save
      redirect_to user_path(@user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      render :new
    end
  end

  def edit
    @pfc = @user.pfc_ratio.find(params[:id])
  end

  def update
    @pfc = @user.pfc_ratio.find(params[:id])
    if @pfc.update_attributes!(pfc_params)
      flash[:success] = "変更に成功しました"
      redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "変更に失敗しました"
      redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  private
      
    def pfc_params
      params.require(:pfc_ratio).permit(:protein, :fat, :carbo)
    end

end
