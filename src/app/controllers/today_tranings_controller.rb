class TodayTraningsController < ApplicationController
    
    before_action :set_user, only: [:index, :create, :update, :show, :destroy, :traning_new, :traning_analysis]
    before_action :set_basic, only: [:index, :traning_analysis]
    before_action :set_analysis_day, only: [:traning_new, :traning_analysis]
    
    
    def index
      @first_day = params[:start_date].nil? ?
      Date.current.beginning_of_month : params[:start_date].to_date
      @last_day = @first_day.end_of_month
      
      @today_tranings = @user.today_tranings.all
      @traningevents = @user.traningevents.all
      
    end
    
    def show  
      
    end
    
    def create
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.new(start_time: params[:start_time], traningevent_id: params[:traningevent_id])
      if @today_traning.save!
        redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録に失敗しました。"
        redirect_to user_today_tranings_traning_new_path(@user, traningevent_id:params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    end
    
    def update
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.find(params[:id])
      @today_analys = @user.traning_analysis.find_by(start_time: params[:start_time], traningevent_id: params[:traningevent_id])
      
      if @today_traning.update_attributes!(today_traning_params)
        
        # Update後、ID別で総負荷を計算して再Update
        @today_traning.update_attributes!(total_load: (@today_traning.traning_weight.to_i * @today_traning.traning_reps.to_i * 1))

        # 同じstart_time・traningevent_idで、first_day: falseのrecordを検索しpluckでtotal_loadのみを配列化。→ 文字列を数字に変換して配列内のtotal_loadを全てsum
        total_load_sum = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: @traningevent).pluck(:total_load).map {|total_sum| total_sum.to_i}.sum
        
        weight_load_max = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: @traningevent).maximum(:traning_weight)
        
        # 最初に作成したTraningAnalysisのIDに上記の@total_load_sumを入れ、Updateする。
        @today_analys.update_attributes!(total_load: total_load_sum, max_load: weight_load_max)
        
        flash[:success] = "更新に成功しました"
        redirect_to user_today_tranings_traning_new_path(current_user, traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "更新に失敗しました"
      end
    end
    
    def destroy
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_traning = @user.today_tranings.find(params[:id])
      @today_traning.destroy
      flash[:success] = "削除しました。"
      redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time]) 
    end
    
    def traning_new
      @today_tranings = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: params[:traningevent_id]).order(:id).pluck(:id)
      @traningevent = @user.traningevents.find(params[:traningevent_id])
    end
    
    def traning_analysis
      @bodyparts = Bodypart.all
      @bodypart = Bodypart.find(params[:bodypart_id])
      @traningevents = @user.traningevents.where(body_part: @bodypart.body_part)
      
      gon.analysis_day = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:start_time)
      gon.analysis_total_load = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:total_load)
      gon.analysis_max_load = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:max_load)
      
    end
    
    private
    
      def today_traning_params
        params.require(:today_traning).permit(:traning_weight, :traning_reps, :traning_note, :traning_name, :traning_event, :body_part, :sub_body_part, :traningevent_id)
      end
    
end
