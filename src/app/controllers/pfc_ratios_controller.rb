class PfcRatiosController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_basic, only: [:new, :create, :edit, :update]

  def new
    @pfc = PfcRatio.new
  end

  def create
    @pfc = PfcRatio.new(pfc_params)
    if @pfc.protein.present? && @pfc.fat.present? && @pfc.fat.present?
      if [@pfc.protein, @pfc.protein, @pfc.carbo].sum == 100
        if @pfc.save
          redirect_to user_setting_path(@user, switching: params[:switching], start_date: Date.current.beginning_of_month, start_time: Date.current)
        else
          render :new
        end
      else
        flash[:danger] = "設定の登録に失敗しました。割合の合計を100％にして下さい。"
        redirect_to new_user_pfc_ratio_path(@user, switching: params[:switching], start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      if @pfc.save
        flash[:success] = "設定の登録に成功しました。"
        redirect_to edit_user_pfc_ratio_path(@user, @pfc, switching: params[:switching], start_date: Date.current.beginning_of_month, start_time: Date.current)
      else
        render :new
      end
    end
  end

  def edit
    @pfc = PfcRatio.find_by(user_id: params[:user_id])
  end

  def update
    @pfc = PfcRatio.find_by(user_id: params[:user_id])
    
    if @pfc.update_attributes(pfc_params)
      flash[:success] = "変更に成功しました"
      redirect_to edit_user_pfc_ratio_path(@user, @pfc, switching: "pfc", start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'edit'
    end
  end

  private

    def pfc_params
      params.require(:pfc_ratio).permit(:protein, :fat, :carbo, :user_id)
    end

end
