class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
=begin
	def registration_alert(organizer, email, event)
		recipients	email 
		from				'Village Organizer <#{organizer.email}>'
		subject			'Register to volunteer!'
		sent_on			Time.now
		body				{:event => event, :url => 'http://usdos.us/users/sign_up'}	
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
