class BodyweightsController < ApplicationController
  before_action :set_basic, only: [:edit]

  def create
    @body_weight = current_user.bodyweights.new(body_weight_params)
    if @body_weight.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_path(current_user, bodyweight_id: @body_weight, start_time: params[:start_time])
    else
      flash[:danger] = "新規作成に失敗しました。"
      redirect_to new_user_bodyweight_path(current_user, start_time: params[:start_time])
    end
  end
  
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
    
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
    @body_weights = current_user.bodyweights.all
  end

  private
    def body_weight_params
      params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage, :start_time)
    end
end
