class UsersController < ApplicationController
  
  def show
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
  end
  
  def calender
    @body_weight = current_user.bodyweights.find_by(start_time: params[:start_time])
  end
end
