class RecipefoodsController < ApplicationController
  
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  def index
    @recipefoods = @user.recipefoods.where()
  end
  
  def new
  end
  
end
