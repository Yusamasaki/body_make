class TargetweightsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @tw = Targetweight.new
  end
  def create
    @user = User.find(params[:user_id])
    @tw = Targetweight.new(targetweight_params)
    if @tw.save
      redirect_to @user
    else
      render :new
    end
  end

  private
  def targetweight_params
    params.require(:targetweight).permit(:body_weight, :bodyfat_parcentage, :target_days, :user_id)
  end
end
