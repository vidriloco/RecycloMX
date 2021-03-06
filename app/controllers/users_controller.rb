class UsersController < ApplicationController
  
  before_filter :authenticate_user!, only: [:update]
  before_filter :find_user, only: [:show, :update]
  before_filter :authenticate_user_is_owner, only: [:update]
  
  def show
    # Tracking user action mixpanel
    Tracker.track_own_user_profile_shown(current_user, @user, request.ip)
    render layout: 'profile'
  end
  
  def update
    if @user.update_with(user_attributes)
      # Tracking user action mixpanel
      Tracker.track_user_updated_profile(current_user, @user, user_attributes, request.ip)
      sign_in(@user, :bypass_sign_in => true)
      flash[:notice] = "Has actualizado tu perfil :)" 
    else
      flash[:error] = "No pudimos actualizar tu perfil :("
    end
    redirect_to user_profile_path(@user)
  end
  
  private
  
  def user_attributes
    params.require(:user).permit(
      :full_name, 
      :email, 
      :password, 
      :bio, 
      :twitter,
      :role,
      :avatar,
      :phone,
      :avatar_cache,
      location: [:address, :coordinates_lon, :coordinates_lat]
    )
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def authenticate_user_is_owner
    @user == current_user
  end
end
