class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :custom_layout
  protected
    
  def after_sign_in_path_for(resource_or_scope)
    if current_user.has_role?(:superuser)
      admin_path
    else
      if session[:pending_offer]
        Offer.assign_user(session[:pending_offer], current_user)
        session[:pending_offer] = nil
      end
      user_activity_path
    end
  end
  
  def custom_layout
    return 'login_registration' if is_a?(Devise::SessionsController) or is_a?(Devise::RegistrationsController) or is_a?(Devise::PasswordsController)
  end
end
