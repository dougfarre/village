class Volunteer < ActiveRecord::Base
	has_many :volunteer_events
	has_many :events, :through => :volunteer_events
	belongs_to :user
	belongs_to :shift
	validates_presence_of :first_name, :last_name, :nick_name, :phone, :email

	require 'rubygems'
	require 'twilio-ruby'

	def send_sms_message(message)
		begin
			number_to_send_to = phone

			unless number_to_send_to.blank?
				twilio_sid = "AC02c0aadc974b42bc996b21f37264210c"
				twilio_token = "b74cb7f19c86b0e80170b41f66dd826e"
				twilio_phone_number = "9177461337"

				@twilio_clinet = Twilio::REST::Client.new twilio_sid, twilio_token

				@twilio_clinet.account.sms.messages.create(
					:from => "#{twilio_phone_number}",
					:to => number_to_send_to,
					:body => message
				)
			end
		end
	end


	def self.csv_import(file_wrapper, event_id)
		event = Event.find(event_id)
	  file = file_wrapper.filename
	 	header = file.gets.strip
		
		keys = header.split(',')
	
		while (line = file.gets)
			params = {}
	   	values = line.strip.split(',')

	    keys.each_with_index do |key,i|
  	    params[key] = values[i]
    	end

			volunteer = event.volunteers.build(params)	
			volunteer.save

		end
	end
end
