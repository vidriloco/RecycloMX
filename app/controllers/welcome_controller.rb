class WelcomeController < ApplicationController
  
  def index
    Tracker.track_event(request.ip, 'Visited index')
    redirect_to(user_activity_path) if user_signed_in?
  end
  
  def picker
    Tracker.track_event(request.ip, 'User as picker')
    session[:user_kind] = User.roles[:picker]
    redirect_to offers_path
  end
  
  def giver
    Tracker.track_event(request.ip, 'User as giver')
    session[:user_kind] = User.roles[:giver]
    redirect_to new_offer_path
  end
  
  def privacy_note
     render layout: 'front' 
  end
end
