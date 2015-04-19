class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  after_filter :check_registered
    
  protected
    
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:full_name, :password, :email, :role, :accepted_privacy_note)
  end
  
  def check_registered
    if resource.persisted?
      # Tracking user registration
      Tracker.track_user_creation_success(resource, request.ip)
    else
      # Tracking user registration
      Tracker.track_user_creation_failure(resource, request.ip)
    end
  end
end