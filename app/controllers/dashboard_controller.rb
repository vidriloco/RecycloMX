#encoding: utf-8
class DashboardController < ApplicationController
  layout 'profile'
  
  before_filter :authenticate_user!, only: [:index]
  
  def index
    @user = current_user
  end
  
end
