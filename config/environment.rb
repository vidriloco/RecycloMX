require 'tlsmail' #key but not always described
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Recyclo::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
# Mailer configuration
ActionMailer::Base.smtp_settings = {
  address: "smtp.1and1.com",
  port: 587,
  authentication: 'login',
  user_name: "contacto@recyclo.mx",
  password: "8080recyclo"
}