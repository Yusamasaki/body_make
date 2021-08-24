class UsersController < ApplicationController
  
  def show
    @body_weight = current_user.bodyweights.find_by(id: params[:bodyweight_id])
    @body_weights = current_user.bodyweights.all
  end
  
end
