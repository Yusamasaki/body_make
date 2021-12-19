class TodaymealsController < ApplicationController

  before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_myfood, only: [:new, :edit, :update]
  before_action :set_meals, only: [:edit, :update]
  before_action :set_nutritions, only: [:index, :new, :create, :edit, :update]
  before_action :set_meals_analysis, only: [:index, :new]
  before_action :set_timezones, only: [:index, :new, :create]
  before_action :set_timezone, only: [:new, :create]
  
  def index

    if params[:timezone_id].present?
      timezones = Timezone.where(id: params[:timezone_id])
    else
      timezones = Timezone.all
    end
    
    # 時間帯別の総摂取栄養素・摂取栄養素
    @timezone_meals = timezones.map {|timezone|
      [
        timezone, @user.todaymeal_recipes.where(start_time: params[:start_time], timezone_id: timezone).pluck(:recipe_id, :amount),
        @user.todaymeals.where(start_time: params[:start_time], timezone_id: timezone).pluck(:myfood_id, :amount)
      ]
    }.map {|timezone, recipe, myfood|
      [
        timezone, recipe.map{|id, amount| [@user.recipes.where(id: id), amount]}, myfood.map{|id, amount| [@user.myfoods.where(id: id), amount]}
      ]
    }.map{|timezone, recipe, myfood|
      [
        timezone, @nutritions.map{|nutrition|
          [recipe.map{|recipe, amount| recipe.pluck(nutrition).sum * amount}.sum, myfood.map{|myfood, amount| myfood.pluck(nutrition).sum * amount}.sum].sum
        }, myfood, recipe
      ]
    }

    @timezone_meal_total = @timezone_meals

    # 一日の総摂取栄養素
    todaymeals_start_time = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount)
    todaymeal_recipes_start_time = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount)

    @day_totalmeals = @nutritions.map {|nutrition|
      todaymeals_start_time.map {|myfood, amount|
        [@user.myfoods.where(id: myfood).pluck(nutrition).sum * amount].sum
      }.sum +
      todaymeal_recipes_start_time.map {|recipe, amount|
        [@user.recipes.where(id: recipe).pluck(nutrition).sum * amount].sum
      }.sum
    }

    @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
    @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])
    if @todaymeals.present? || @todaymeal_recipes.present?
      gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
      calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
        (
          todaymeals_start_time.map {|myfood, amount|
            [@user.myfoods.where(id: myfood).pluck(nutrition).sum * amount].sum
          }.sum +
          todaymeal_recipes_start_time.map {|recipe, amount|
            [@user.recipes.where(id: recipe).pluck(nutrition).sum * amount].sum
          }.sum
        ) * ratio
      }
      gon.myfoods = calories.map{|calorie|
        ((calorie / calories.sum) * 100).floor(1)
      }
      gon.total_calorie = calories.sum
    end
  end

  def new
    @todaymeal = @user.todaymeals.new
    
    gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
      calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
        @user.myfoods.where(id: params[:myfood_id]).pluck(nutrition).sum * ratio
      }
    gon.myfoods = calories.map{|calorie|
      ((calorie / calories.sum) * 100).floor(1)
    }
    gon.total_calorie = calories.sum
  end

  def create
    @todaymeal = @user.todaymeals.new(todaymeal_params)
    @myfood = @user.myfoods.find(params[:myfood_id]) if params[:myfood_id].present?
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    
    todaymeal_valid = @user.todaymeals.find_by(start_time: params[:start_time], timezone_id: params[:timezone_id], myfood_id: @myfood)
    if todaymeal_valid.nil?
      if @todaymeal.save
        
        # -------- @meals_analyのUpdate機能 --------

          @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
          @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])

            if @todaymeals.present?
              myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount|
                          [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            if @todaymeal_recipes.present?
              recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount|
                          [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end

            if @todaymeals.present? && @todaymeal_recipes.present?
              total = myfoods + recipes
            elsif @todaymeals.present? && @todaymeal_recipes.blank?
              total = myfoods
            elsif @todaymeal_recipes.present? && @todaymeals.blank?
              total = recipes
            else
              total = nil
            end

        @meals_analys.update_attributes!(calorie: total)

        # -------- @meals_analyのUpdate機能 --------

        flash[:success] = "#{@myfood.food_name}の登録に成功しました。"
        redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
      else
        render 'new'
      end
    else
      flash[:danger] = "登録に失敗しました。#{params[:start_time]}の#{@timezone.time_zone}には#{@myfood.food_name}は登録してあります。分量などで調整下さい。"
      redirect_to new_user_todaymeal_path(@user, myfood_id: params[:myfood_id], timezone_id: params[:timezone_id], start_date: params[:start_date], start_time: params[:start_time])
    end
  end

  def edit
    @todaymeal = @user.todaymeals.find(params[:id])

    gon.food_name = [:protein, :fat, :carbo].map{|nutrition| Myfood.human_attribute_name(nutrition)}
      calories = [[:protein, 4], [:fat, 9], [:carbo, 4]].map {|nutrition, ratio|
        @user.myfoods.where(id: params[:myfood_id]).pluck(nutrition).sum * ratio
      }
    gon.myfoods = calories.map{|calorie|
      ((calorie / calories.sum) * 100).floor(1)
    }
    gon.total_calorie = calories.sum
  end

  def update
    @todaymeal = @user.todaymeals.find(params[:id])
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])
    
    if @todaymeal.update_attributes(todaymeal_params)
      
        # -------- @meals_analyのUpdate機能 --------

          @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
          @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])

            if @todaymeals.present?
              myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount|
                          [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end
            if @todaymeal_recipes.present?
              recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount|
                          [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                        }.sum.sum
            end

            if @todaymeals.present? && @todaymeal_recipes.present?
              total = myfoods + recipes
            elsif @todaymeals.present? && @todaymeal_recipes.blank?
              total = myfoods
            elsif @todaymeal_recipes.present? && @todaymeals.blank?
              total = recipes
            else
              total = nil
            end

        @meals_analys.update_attributes!(calorie: total)

        # -------- @meals_analyのUpdate機能 --------

      flash[:success] = "更新に成功しました"
      redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
    else
      render 'edit'
    end
  end

  def destroy
    @todaymeal = @user.todaymeals.find(params[:id])
    @myfood = @user.myfoods.find(@todaymeal.myfood_id)
    @meals_analys = @user.meals_analysis.find_by(start_time: params[:start_time])

    @todaymeal.destroy

      # -------- @meals_analyのUpdate機能 --------

        @todaymeals = @user.todaymeals.where(start_time: params[:start_time])
        @todaymeal_recipes = @user.todaymeal_recipes.where(start_time: params[:start_time])

          if @todaymeals.present?
            myfoods = @user.todaymeals.where(start_time: params[:start_time]).pluck(:myfood_id, :amount).map{ |myfood, amount|
                        [ @user.myfoods.where(id: myfood).pluck(:calorie).sum * amount ]
                      }.sum.sum
          end
          if @todaymeal_recipes.present?
            recipes = @user.todaymeal_recipes.where(start_time: params[:start_time]).pluck(:recipe_id, :amount).map{|recipe, amount|
                        [ @user.recipes.where(id: recipe).pluck(:calorie).sum * amount ]
                      }.sum.sum
          end

          if @todaymeals.present? && @todaymeal_recipes.present?
            total = myfoods + recipes
          elsif @todaymeals.present? && @todaymeal_recipes.blank?
            total = myfoods
          elsif @todaymeal_recipes.present? && @todaymeals.blank?
            total = recipes
          else
            total = nil
          end

        @meals_analys.update_attributes!(calorie: total)

        # -------- @meals_analyのUpdate機能 --------

    flash[:success] = "#{@myfood.food_name}を削除しました。"
    redirect_to user_todaymeals_path(@user, start_date: params[:start_date], start_time: params[:start_time])
  end

  private

    def todaymeal_params
      params.require(:todaymeal).permit(:start_time, :myfood_id, :timezone_id, :amount, :note)
    end

end
