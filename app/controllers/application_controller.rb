class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    
  layout :custom_layout
  protected
  
  def track_sign_in
    # Tracking user action mixpanel
    Tracker.track_event(request.ip, 'User will sign in')
  end
  
  def track_sign_up
    # Tracking user action mixpanel
    Tracker.track_event(request.ip, 'User will sign up')
  end
  
  def track_new_password
    # Tracking user action mixpanel
    Tracker.track_event(request.ip, 'User asking to recover password')
  end
  
  def track_edit_password
    # Tracking user action mixpanel
    Tracker.track_event(request.ip, 'User editing password')
  end
    
  def after_sign_in_path_for(resource_or_scope)
    session[:user_kind] = nil
    if current_user.has_role?(:superuser)
      admin_path
    else
      if session[:pending_offer]
        Offer.assign_user(session[:pending_offer], current_user)
        session[:pending_offer] = nil
      end
      
      if current_user.is_a_picker?
        offers_path
      else
        user_activity_path
      end
    end
  end
  
  def custom_layout
    return 'front' if is_a?(Devise::SessionsController) or is_a?(Devise::RegistrationsController) or is_a?(Devise::PasswordsController)
  end
end
