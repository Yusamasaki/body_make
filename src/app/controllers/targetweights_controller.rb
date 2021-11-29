class TargetweightsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_basic, only: [:new, :edit]

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
    ActiveRecord::Base.transaction do 
      @tw.save!
      redirect_to user_path(@user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    rescue ActiveRecord::RecordInvalid
      render :new
    end
  end

  def edit
    @tw = Targetweight.find_by(user_id: @user.id)
  end

  def update
    @tw = Targetweight.find_by(user_id: @user.id)
    ActiveRecord::Base.transaction do
      @tw.update_attributes!(targetweight_params)
      flash[:success] = "更新完了しました"
      redirect_to edit_user_targetweight_path(@user, @tw, switching: "target", start_date: params[:start_date], start_time: params[:start_time])
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "更新に失敗しました"
      redirect_to edit_user_targetweight_path(@user, @tw, switching: "target", start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  private
  def targetweight_params
    params.require(:targetweight).permit(:now_body_weight, :goal_body_weight, :now_bodyfat_percentage, :goal_bodyfat_percentage, 
                                         :beginning_date, :target_date, :user_id
                                        )
  end
end
