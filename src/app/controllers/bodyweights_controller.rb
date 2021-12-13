class BodyweightsController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :calender]
  before_action :set_user, only: [:edit, :update, :calender, :bodyfat_percentage_edit]
  before_action :set_basic, only: [:edit]

  def edit
    @body_weight = current_user.bodyweights.find(params[:id])
  end
  
  def bodyfat_percentage_edit
    @body_weight = current_user.bodyweights.find(params[:id])
  end

  def update
    @body_weight = current_user.bodyweights.find(params[:id])
    if @body_weight.update_attributes(body_weight_params)
      if @body_weight.bodyfat_percentage.present?
        flash[:success] = "#{@body_weight.start_time}の記録を完了しました"
        redirect_to user_path(current_user, bodyweight_id: @body_weight, start_date: params[:start_date], start_time: params[:start_time])
      else
        errors.add(:body_weight, "が必要です")
        redirect_to user_path(current_user, bodyweight_id: @body_weight, start_date: params[:start_date], start_time: params[:start_time])
      end
    else
      render 'edit'
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
      params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage, :bodyweight, :start_time, :start_date)
    end
end
