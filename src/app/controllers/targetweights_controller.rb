class TargetweightsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]

  def set_user
    @user= User.find(params[:user_id])
  end
  
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
      redirect_to new_user_bmr_path
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
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def targetweight_params
    params.require(:targetweight).permit(:body_weight, :bodyfat_parcentage, :target_days, :user_id)
  end
end
