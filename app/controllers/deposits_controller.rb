#encoding: utf-8
class DepositsController < ApplicationController
  layout 'full_map'
  
  before_filter :authenticate_user!
  
  def index
    if current_user.is_a_picker?
      @deposits = Deposit.all
      # Tracking user action mixpanel
      Tracker.track_user_searching_for_deposits(current_user, request.ip)
    else
      flash[:error] = "No estás habilitado para acceder a la lista de depósitos"
      redirect_to user_profile_path(current_user)
    end
  end
  
end
