# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default "X-SMTPAPI" => '{"category": "Main"}'
ActionMailer::Base.smtp_settings = {
	:user_name => "dougfarre",
	:password => "h2k21162",
	:domain => "usdos.us",
	:address => "smtp.sendgrid.net",
	:port => 25,
	:authentication => :plain,
	:enable_starttls_auto => true
}
# Initialize the rails application
Vms::Application.initialize!
