class SendSmsController < ApplicationController
	def index
	end

	def send_sms_message
		shift = Shift.find(params[:shift_id])
		shift.send_sms_message
=begin
		number_to_sent_to Volunteer.find(shift.volunteer_id).phone
		area = shift.slot.area.name
		start_time = shift.slot.start_time

		twilio_sid = "AC02c0aadc974b42bc996b21f37264210c"
		twilio_token = "b74cb7f19c86b0e80170b41f66dd826e"
		twilio_phone_number = "9177461337"

		@twilio_clinet = Twilio::REST::Client.new twilio_sid, twilio_token

		@twilio_clinet.account.sms.messages.create(
			:from => "+1#{twilio_phone_number}",
			:to => number_to_send_to,
			:body => "Your shift in the #{area} Area is starting at #{start_time}"
		)
=end
	end
end
