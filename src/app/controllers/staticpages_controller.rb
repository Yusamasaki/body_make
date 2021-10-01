class StaticpagesController < ApplicationController
  before_action :log_out_user, only: [:top]
  
  def top
  end
end
