class TargetweightsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_basic, only: [:new, :edit]

  def new
    if Targetweight.where(user_id: @user.id).blank?
      @tw = Targetweight.new
    else
      flash[:success] = "登録済みです"
      redirect_to @user
    end
  end
  def create
    @tw = Targetweight.new(targetweight_params)
    if @tw.save
      redirect_to user_path(@user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      render :new
    end
  end

  def edit
    @tw = Targetweight.find_by(user_id: @user.id)
  end

  def update
    @tw = Targetweight.find_by(user_id: @user.id)
    if @tw.update_attributes(targetweight_params)
      flash[:success] = "更新完了しました"
      redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      render :edit
    end
  end

  private
  def targetweight_params
    params.require(:targetweight).permit(:now_body_weight, :goal_body_weight, :now_bodyfat_percentage, :goal_bodyfat_percentage, 
                                         :beginning_date, :target_date, :user_id
                                        )
  end
end
