class UsersController < ApplicationController
  layout 'profile'
  
  before_filter :authenticate_user!, only: [:activity, :update]
  before_filter :find_user, only: [:show, :update]
  before_filter :authenticate_user_is_owner, only: [:activity, :update]
  
  
  def activity
    @user = current_user
  end
  
  def show
  end
  
  def update
    if @user.update_with(user_attributes)
      sign_in(@user, :bypass => true)
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
