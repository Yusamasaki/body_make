class TodayTraningsController < ApplicationController
    
    before_action :set_user, only: [:index, :create, :update, :show, :destroy, :traning_new]
    
    
    def index
      
      @first_day = params[:start_date].nil? ?
      Date.current.beginning_of_month : params[:start_date].to_date
      @last_day = @first_day.end_of_month
      
      one_month = [*@first_day..@last_day]
      
      @today_traning_days = @user.today_traning_days.where( start_time: @first_day..@last_day).order(:start_time)
      
      unless one_month.count == @today_traning_days.count
        ActiveRecord::Base.transaction do
          one_month.each { |day| @user.today_traning_days.create!(start_time: day) }
        end
        @today_traning_days = @user.today_traning_days.where(start_time: @first_day..@last_day).order(:start_time)
      end
      
      @today_traning_day = @user.today_traning_days.find_by(start_time: params[:start_time])
      
      @traningevents = @user.traningevents.all
      
      @today_tranings = @user.today_tranings.where(start_time: params[:start_time]).pluck(:id)
      
    end
    
    def show  
      
    end
    
    def create
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.new(start_time: params[:start_time], traningevent_id: params[:traningevent_id], traning_name: @traningevent.traning_name)
      if @today_traning.save!
        redirect_to user_today_tranings_traning_new_path(@user, today_traning_day_id: params[:today_traning_day_id], traningevent_id: params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録に失敗しました。"
        redirect_to user_today_tranings_traning_new_path(@user, today_traning_day_id: params[:today_traning_day_id], traningevent_id:params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    end
    
    def update
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.find(params[:id])
      if @today_traning.update_attributes!(today_traning_params)
        flash[:success] = "更新に成功しました"
        redirect_to user_today_tranings_traning_new_path(current_user, today_traning_day_id: params[:today_traning_day_id], traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "更新に失敗しました"
      end
    end
    
    def destroy
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.find(params[:id])
      @today_traning.destroy
      flash[:success] = "削除しました。"
      redirect_to user_today_tranings_traning_new_path(@user, today_traning_day_id: params[:today_traning_day_id], traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time]) 
    end
    
    def traning_new
      @today_tranings = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: params[:traningevent_id]).pluck(:id)
      @traningevent = @user.traningevents.find(params[:traningevent_id])
    end
    
    private
    
      def today_traning_params
        params.require(:today_traning).permit(:traning_weight, :traning_reps, :traning_note)
      end
    
end
