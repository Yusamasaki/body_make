class BodyweightsController < ApplicationController
  def index
    @body_weights = current_user.bodyweights.where(start_time: params[:start_time])
  end

  def new
    @body_weight = current_user.bodyweights.new
  end

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

  def show
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

  def destroy
    @body_weight = current_user.bodyweights.find(params[:id])
    @body_weight.destroy
    flash[:danger] = "#{@body_weight.body_weight}を削除しました"
    redirect_to user_bodyweights_path(current_user, start_time: params[:start_time])
  end

  private
    def body_weight_params
      params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage, :start_time)
    end
end
