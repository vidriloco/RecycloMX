class WelcomeController < ApplicationController
  
  def index
  end
  
  def picker
    session[:user_kind] = User.roles[:picker]
    redirect_to offers_path
  end
  
  def giver
    session[:user_kind] = User.roles[:giver]
    redirect_to new_offer_path
  end
end
