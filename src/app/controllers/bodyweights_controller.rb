class BodyweightsController < ApplicationController
  def index
  end

  def new
    @body_weight = current_user.bodyweights.new
  end

  def create
    @body_weight = current_user.bodyweights.new(body_weight_params)
    if @body_weight.save
      flash[:success] = "新規作成に成功しました。"
      redirect_to ""
    else
      flash[:danger] = "新規作成に失敗しました。"
      redirect_to ""
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
    def body_weight_params
      params.require(:bodyweight).permit(:body_weight, :bodyfat_percentage)
    end
end
