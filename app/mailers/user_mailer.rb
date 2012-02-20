class UserMailer < ActionMailer::Base
	include SendGrid
	sendgrid_enable :ganalytics, :opentrack
  default from: "Village Manager <vms@vms.com>"


	def registration_alert(email, event)
		@event = event
		@url = 'http://usdos.us/users/sign_up'

		mail( :to => email,
          :subject => @event.name + ': registeer to volunteer!') do |format|
      format.html
    end
	end


	def add_alert(volunteer, event)
		@event = event
		@volunteer = volunteer

		@url = 'http://usdos.us/users/sign_in'
		mail( :to => @volunteer.email,
          :subject => @event.name + ': you have been signed up to volunteer!') do |format|
      format.html
    end
	end


	def update_alert(volunteer, event)
		@event = event
		@volunteer = volunteer
		@url = 'http://usdos.us/users/sign_in'

		mail( :to => @volunteer.email,
          :subject => @event.name + ': important update' do |format|
      format.html
    end
	end


	def add_alert (organizer, email, event)
		recipients	email 
		from				'Village Organizer <#{organizer.email}>'
		subject			'You have been signed up to volunteer'
		sent_on			Time.now
		body				{:event_id => event_id, :url => 'http://usdos.us/users/sign_in'}	
	end

	def update_alert
		recipients	email 
		from				'Village Organizer <#{organizer.email}>'
		subject			'You have been signed up to volunteer'
		sent_on			Time.now
		body				{:event_id => event_id, :url => 'http://usdos.us/users/sign_in'}	
	end
=end
end
