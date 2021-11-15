class TodayTraningsController < ApplicationController
    
    before_action :set_user, only: [:index, :create, :update, :destroy, :traning_new, :traning_analysis, :chart, :chart_traningevent, :event]
    before_action :set_basic, only: [:index, :traning_analysis, :chart, :chart_traningevent]
    before_action :set_analysis_day, only: [:traning_new, :traning_analysis, :index, :chart, :chart_traningevent]
    before_action :set_traningevent, only: [:create, :update, :destroy]
    before_action :start_time_next_valid, only: [:index, :traning_new, :traning_analysis, :chart, :chart_traningevent]
    
    
    def index
      @today_tranings = @user.today_tranings.all
      
      @bodyparts = Bodypart.all
      
      @traningevents = @bodyparts.pluck(:id).map{|bodypart|
        [bodypart, @user.traningevents.where(bodypart_id: bodypart).pluck(:id, :traning_name)]
      }
      
    end
    
    def create
      @today_traning = @user.today_tranings.new(start_time: params[:start_time], traningevent_id: params[:traningevent_id])
      if @today_traning.save!
        redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      else
        flash[:danger] = "登録に失敗しました。"
        redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      end
      
    end
    
    def update
      @today_traning = @user.today_tranings.find(params[:id])
      @today_analys = @user.traning_analysis.find_by(start_time: params[:start_time], traningevent_id: params[:traningevent_id])
      
      ActiveRecord::Base.transaction do 
        @today_traning.update_attributes!(today_traning_params)
        
        # Update後、ID別で総負荷を計算して再Update
        @today_traning.update_attributes!(total_load: (@today_traning.traning_weight.to_i * @today_traning.traning_reps.to_i * 1))

        # 同じstart_time・traningevent_idでrecordを検索しpluckでtotal_loadのみを配列化。→ 文字列を数字に変換して配列内のtotal_loadを全てsum
        total_load_sum = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: @traningevent).pluck(:total_load).map {|total_sum| total_sum.to_i}.sum
        
        # 同じstart_time・traningevent_idでrecordを検索しtraning_weightのみのmax値を求める。
        weight_load_max = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: @traningevent).maximum(:traning_weight)
        
        # 最初に作成したTraningAnalysisのIDに上記の@total_load_sum・weight_load_maxを入れ、Updateする。
        @today_analys.update_attributes!(total_load: total_load_sum, max_load: weight_load_max)
        
        flash[:success] = "更新に成功しました"
        redirect_to user_today_tranings_traning_new_path(current_user, traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time])
      rescue ActiveRecord::RecordInvalid
        flash[:danger] = "更新に失敗しました"
        redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: params[:traningevent_id], start_date: params[:start_date], start_time: params[:start_time])
      end
    end
    
    def destroy
      @today_traning = @user.today_tranings.find(params[:id])
      @today_traning.destroy
      flash[:success] = "削除しました。"
      redirect_to user_today_tranings_traning_new_path(@user, traningevent_id: @traningevent, start_date: params[:start_date], start_time: params[:start_time]) 
    end
    
    def traning_new
      @traningevent = @user.traningevents.find(params[:traningevent_id])
      @today_tranings = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: @traningevent).order(:id).pluck(:id)
      
      unless @today_tranings.count >= 3
        ActiveRecord::Base.transaction do
          3.times { |traning| current_user.today_tranings.create!(start_time: params[:start_time], traningevent_id: params[:traningevent_id]) }
        end
        @today_tranings = @user.today_tranings.where(start_time: params[:start_time], traningevent_id: params[:traningevent_id]).order(:id).pluck(:id)
      end
      
      
    end
    
    def traning_analysis
      @bodyparts = Bodypart.all
      @bodypart = Bodypart.find(params[:bodypart_id])
      @traningevents = @user.traningevents.where(bodypart_id: @bodypart)
    end
    
    def chart
      @bodyparts = Bodypart.all
      
      @traningevents = @bodyparts.pluck(:id).map{|bodypart|
        [bodypart, @user.traningevents.where(bodypart_id: bodypart).pluck(:id, :traning_name)]
      }
      
      @traning_analysis = @traningevents.map{|bodypart, traningevents|
        traningevents.map{|id, name|
          [
            id, gon.day = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:start_time).map{|day| day.day}, gon.total = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:total_load), gon.max = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:max_load)
          ]
        }
      }
    end
    
    def chart_traningevent
      @bodyparts = Bodypart.all
      
      @traningevents = @bodyparts.pluck(:id).map{|bodypart|
        [bodypart, @user.traningevents.where(bodypart_id: bodypart).pluck(:id, :traning_name)]
      }
      
      @traning_analysis = @traningevents.map{|bodypart, traningevents|
        traningevents.map{|id, name|
          [
            id, gon.day = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:start_time).map{|day| day.day}, gon.total = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:total_load), gon.max = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: id).order(:start_time).pluck(:max_load)
          ]
        }
      }
      
      @first_day = params[:start_date].nil? ?
      Date.current.beginning_of_month : params[:start_date].to_date
      @last_day = @first_day.end_of_month
      # グラフ横軸(日にち)
      @analysis_day = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:start_time).map{|day| day.day}
      
      # グラフ縦軸(総負荷)
      @analysis_total_load = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:total_load).map{|total| total.to_i}
      
      # グラフ縦軸(MAX重量)
      @analysis_max_load = @user.traning_analysis.where( start_time: @first_day..@last_day, traningevent_id: params[:traningevent_id]).order(:start_time).pluck(:max_load).map{|max| max.to_i}
    end
    
    private
    
      def today_traning_params
        params.require(:today_traning).permit(:traning_weight, :traning_reps, :traning_note, :bodypart_id)
      end
    
end
