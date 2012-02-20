# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
	:user_name => "dougfarre",
	:password => "h2k21162",
	:domain => "securitysport.com",
	:address => "smtp.sendgrid.net",
	:port => 587,
	:authentication => :plain,
	:enable_starttls_auto => true
}
# Initialize the rails application
Vms::Application.initialize!

