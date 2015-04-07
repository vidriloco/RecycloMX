#encoding: utf-8
class DashboardController < ApplicationController
  layout 'profile'
  
  before_filter :authenticate_user!, only: [:index]
  
  def index
    @user = current_user
    # Tracking user action mixpanel
    Tracker.track_user_visited_dashboard(current_user, request.ip)
  end
  
end
