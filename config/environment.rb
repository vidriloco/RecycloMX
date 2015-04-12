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
  address: "smtp.gmail.com",
  port: 587,
  authentication: 'plain',
  user_name: "no-reply@recyclo.mx",
  password: "8080recyclo",
  domain: 'www.recyclo.mx',
  enable_starttls_auto: true
}