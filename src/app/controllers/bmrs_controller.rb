class BmrsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @bmr = Bmr.new
  end

  def create
    @user = User.find(params[:user_id])
    @bmr = Bmr.new(bmr_params)
    if @bmr.save
      redirect_to user_path(@user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      render :new
    end
  end

  private

  def bmr_params
    params.require(:bmr).permit(:gender, :age, :height, :user_id)
  end
end
