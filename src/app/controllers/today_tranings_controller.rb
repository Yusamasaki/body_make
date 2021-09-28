class TodayTraningsController < ApplicationController
    
    before_action :set_user, only: [:index, :create, :update, :show, :destroy]
    
    def index
      
      @first_day = params[:start_date].nil? ?
      Date.current.beginning_of_month : params[:start_date].to_date
      @last_day = @first_day.end_of_month
      
      one_month = [*@first_day..@last_day]
      
      @today_tranings = @user.today_tranings.where( start_time: @first_day..@last_day).order(:start_time)
      
      unless one_month.count == @today_tranings.count
        ActiveRecord::Base.transaction do
          one_month.each { |day| @user.today_tranings.create!(start_time: day) }
        end
        @today_tranings = @user.today_tranings.where(start_time: @first_day..@last_day).order(:start_time)
      end
      
      @today_traning = @user.today_tranings.find_by(start_time: params[:start_time])
      
    end
    
    def show
      
      @today_tranings = @user.today_tranings.where(start_time: params[:start_time]).pluck(:id)
      
    end
    
    def create
      @today_traning = @user.today_tranings.new(start_time: params[:start_time])
      if @today_traning.save
        redirect_to user_today_traning_path(@user, @today_traning, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録に失敗しました。"
        redirect_to user_today_traning_path(@user, @today_traning, start_date: params[:start_date], start_time: params[:start_time])
      end
    end
    
    def update
    end
    
    def destroy
      @today_traning = @user.today_tranings.find(params[:id])
      @today_traning.destroy
      flash[:success] = "削除しました。"
      redirect_to user_today_traning_path(@user, @today_traning, start_date: params[:start_date], start_time: params[:start_time]) 
    end
    
end
