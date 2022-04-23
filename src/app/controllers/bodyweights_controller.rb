class BodyweightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :calender, :bodyfat_percentage_edit, :bodyfat_percentage_update]
  before_action :set_basic, only: [:edit]

  def edit
    @body_weight = current_user.bodyweights.find(params[:id])
  end

  def bodyfat_percentage_edit
    @body_weight = current_user.bodyweights.find(params[:bodyweight_id])
  end

  def update
    @body_weight = current_user.bodyweights.find(params[:id])
    @body_weight.update_attributes!(body_weight_params)
    if @body_weight.body_weight.present?
      flash[:success] = "#{@body_weight.start_time}の記録を完了しました"
      redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "記録に失敗しました。体重を入力してください。"
      redirect_to edit_user_bodyweight_path(@user, @body_weight, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def bodyfat_percentage_update
    @body_weight = @user.bodyweights.find(params[:bodyweight_id])
    @body_weight.update_attributes!(body_weight_params)
    if @body_weight.bodyfat_percentage.present?
      flash[:success] = "#{@body_weight.start_time}の記録を完了しました"
      redirect_to user_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "記録に失敗しました。体脂肪率を入力してください。"
      redirect_to user_bodyweight_bodyfat_percentage_edit_path(@user, @body_weight, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def calender
    @first_day = params[:start_date].nil? ?
    Date.current.beginning_of_month : params[:start_date].to_date
    @last_day = @first_day.end_of_month
    @body_weight = @user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = @user.bodyweights.all
  end

  private

  def body_weight_params
    params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage, :start_time)
  end
end
