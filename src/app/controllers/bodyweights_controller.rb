class BodyweightsController < ApplicationController
  def index
    @body_weights = current_user.bodyweights.all
  end

  def new
    @body_weight = current_user.bodyweights.new
  end

  def create
    @body_weight = current_user.bodyweights.new(body_weight_params)
    if @body_weight.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to user_bodyweights_path(current_user)
    else
      flash[:danger] = "新規作成に失敗しました。"
      redirect_to user_bodyweights_path(current_user)
    end
  end

  def show
  end
  
  def edit
    @body_weight = current_user.bodyweights.find(params[:id])
  end

  def update
    @body_weight = current_user.bodyweights.find(params[:id])
    if @body_weight.update_attributes!(body_weight_params)
      flash[:success] = "更新に成功しました。"
      redirect_to user_bodyweights_path(current_user)
    else
      flash[:danger] = "更新に失敗しました。"
      redirect_to user_bodyweights_path(current_user)
    end
  end

  def destroy
    @body_weight = current_user.bodyweights.find(params[:id])
    @body_weight.destroy
    flash[:danger] = "#{@body_weight.body_weight}を削除しました"
    redirect_to user_bodyweights_path(current_user)
  end

  private
    def body_weight_params
      params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage, :start_time)
    end
end
