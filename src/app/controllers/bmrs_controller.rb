class BmrsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_basic, only: [:new, :edit, :update]

  def new
    if Bmr.where(user_id: @user).blank?
      @bmr = Bmr.new
    else
      flash[:success] = "登録済みです"
      redirect_to @user
    end
  end

  def create
    @bmr = Bmr.new(bmr_params)
    if @bmr.save
      redirect_to new_user_targetweight_path(@user, start_date: Date.current.beginning_of_month, start_time: Date.current)
    else
      render :new
    end
  end

  def edit
    @bmr = Bmr.find_by(user_id: @user)
  end

  def update
    @bmr = Bmr.find_by(user_id: @user.id)
    if @bmr.update_attributes(bmr_params)
      flash[:success] = "更新しました"
      redirect_to edit_user_bmr_path(@user, @bmr, switching: params[:switching], start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'edit'
    end


  end

  private

  def bmr_params
    params.require(:bmr).permit(:gender, :age, :height, :user_id, :activity)
  end
end
