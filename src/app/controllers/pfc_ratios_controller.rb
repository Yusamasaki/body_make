class PfcRatiosController < ApplicationController

  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_basic, only: [:new, :edit]

  def new
    @pfc = PfcRatio.new
  end

  def create
    @pfc = PfcRatio.new(pfc_params)
    if @pfc.save
      redirect_to user_path(@user, pfc_if: @pfc, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      render :new
    end
  end

  def edit
    @pfc = PfcRatio.find_by(user_id: params[:user_id])
  end

  def update
    @pfc = PfcRatio.find_by(user_id: params[:user_id])
    ActiveRecord::Base.transaction do
      if @pfc.update_attributes!(pfc_params)
        flash[:success] = "変更に成功しました"
        redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "変更に失敗しました"
        redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to edit_user_pfc_ratio_url(start_date: params[:start_date], start_time: params[:start_time])
  end

  private
      
    def pfc_params
      params.require(:pfc_ratio).permit(:protein, :fat, :carbo, :user_id)
    end

end
