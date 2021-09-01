class BmrsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]


  def new
    if Bmr.where(user_id: @user.id).blank?
      @bmr = Bmr.new
    else
      flash[:success] = "登録済みです"
      redirect_to @user
    end
  end

  def create
    @bmr = Bmr.new(bmr_params)
    if @bmr.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @bmr = Bmr.find_by(user_id: @user.id)
  end

  def update
    @bmr = Bmr.find_by(user_id: @user.id)
    if @bmr.update_attributes(bmr_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      render :edit
    end


  end

  private

  def bmr_params
    params.require(:bmr).permit(:gender, :age, :height, :user_id)
  end
end
