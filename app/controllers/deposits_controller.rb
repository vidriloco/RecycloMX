class DepositsController < ApplicationController
  layout 'full_map'
  
  before_filter :authenticate_user!
  
  def index
    @deposits = Deposit.all
  end
  
end
