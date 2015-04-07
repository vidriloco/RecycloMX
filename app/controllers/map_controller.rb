class MapController < ApplicationController
  include MainHelper
  
  layout 'map_layout'
  
  before_filter :authenticate_user!
  
  def index
    respond_to do |format|
      format.html
    end
  end
end
