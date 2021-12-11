class BodyweightsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :calender]
  before_action :set_user, only: [:edit, :calender]
  before_action :set_basic, only: [:edit, :calender]

  def edit
    @body_weight = current_user.bodyweights.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @body_weight = current_user.bodyweights.find(params[:id])
      if @body_weight.update_attributes!(body_weight_params)
        flash[:success] = "#{@body_weight.start_time}の体重を記録しました"
        redirect_to user_path(current_user, bodyweight_id: @body_weight, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "記録に失敗しました。"
        redirect_to user_path(current_user, bodyweight_id: @body_weight, start_date: params[:start_date], start_time: params[:start_time])
      end
      end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to edit_user_bodyweight_url(start_date: params[:start_date], start_time: params[:start_time])
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
