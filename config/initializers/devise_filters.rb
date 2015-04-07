# Put this somewhere it will get auto-loaded, like config/initializers
module DeviseFilters
  def self.add_filters
    Devise::SessionsController.before_filter :track_sign_in, only: [:new]
    Devise::PasswordsController.before_filter :track_new_password, only: [:new]
    Devise::RegistrationsController.before_filter :track_sign_up, only: [:new]
    Devise::PasswordsController.before_filter :track_edit_password, only: [:edit]
  end

  self.add_filters
end
