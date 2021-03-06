class UserMailer < ActionMailer::Base
	include SendGrid
	sendgrid_enable :ganalytics, :opentrack
  default from: "Conference Manager <vms@vms.com>"


	def registration_alert(email, event)
		@event = event
		@url = 'http://129.7.138.217/users/sign_up'

		mail( :to => email,
          :subject => @event.name + ': register to volunteer!') do |format|
      format.html
    end
	end


	def add_alert(volunteer, event)
		@event = event
		@volunteer = volunteer

		@url = 'http://129.7.138.217/users/sign_in'
		mail( :to => @volunteer.email,
          :subject => @event.name + ': you have been signed up to volunteer!') do |format|
      format.html
    end
	end


	def update_alert(volunteer, event)
		@event = event
		@volunteer = volunteer
		@url = 'http://129.7.138.217/users/sign_in'

		mail( :to => @volunteer.email,
          :subject => @event.name + ': important update') do |format|
      format.html
    end
	end

	def shift_alert(shift)
		@shift = shift

		begin
			email = Volunteer.find(@shift.volunteer_id).email
		rescue
			email = ""
		end

		unless email.blank?
			mail( :to => email,
					  :from => "vsmmaster@129.7.138.217",
          	:subject => @shift.slot.area.village.event.name + ': your shift is starting soon!') do |format|
      	format.html
			end
		end
	end	


	def aux_alert(email, message, subject)
		@message = message

		mail( :to => email,
					:from => "vsmmater@udsos.us",
          :subject => subject) do |format|
      format.html
		end
	end
end
