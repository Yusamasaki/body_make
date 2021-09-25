class TraningeventsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :show]
  before_action :traning_set, only: [:index, :new, :create, :edit, :update, :show]
  
  def index
    
  end
  
  def new
    @traningtype = Traningtype.find(params[:traningtype_id])
    @traningevent = @user.traningevents.new
  end
  
  def create
    @traningevent = @user.traningevents.new(traningevent_params)
    if @traningevent.save
      redirect_to user_traningevents_path(current_user, start_date: params[:start_date], start_time: params[:start_time])
    else
      flash[:danger] = "登録に失敗しました。"
      redirect_to new_user_traningevent_path(current_user, start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def edit
  end
  
  def update
  end

  def show
  end

  private
    def traningevent_params
      params.require(:traningevent).permit(:bodypart, :sub_bodypart, :traning_name, :traningtype_id)
    end
  
end
