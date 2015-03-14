class DashboardController < ApplicationController
  layout 'profile'
  
  before_filter :authenticate_user!, only: [:activity]
  
  def index
    @user = current_user
  end
  
end
