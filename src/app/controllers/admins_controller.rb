class AdminsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :authenticate_admin!

  def show
  end
end
