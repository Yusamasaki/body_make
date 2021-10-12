class TodaymealsController < ApplicationController
  
  before_action :set_user, only: [:index]
  before_action :set_basic, only: [:index]
  
  def index
    @timezones = Timezone.all
  end
  
end
