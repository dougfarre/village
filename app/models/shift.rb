class ShiftValidator < ActiveModel::Validator
	def validate(record)
		other_shifts = Shift.where(:slot_id => record.slot_id)

		unless other_shifts.blank?
			record.errors[:base] << "This volunteer is already registered for this slot."
		end
	end
end


class Shift < ActiveRecord::Base
	belongs_to :slot
	has_one :volunteer
	validates_uniqueness_of :slot_id, :scope => :volunteer_id,
													:unless => Proc.new {|shift| shift.volunteer_id.blank?}

	#validates_with ShiftValidator
	include ApplicationHelper

	require 'rubygems'
	require 'twilio-ruby'

	def send_sms_message
		begin
			number_to_send_to = Volunteer.find(volunteer_id).phone

			unless number_to_send_to.blank?
				puts "inside send_sms_message2"
				area = slot.area.name
				start_time = slot.start_time

				twilio_sid = "AC02c0aadc974b42bc996b21f37264210c"
				twilio_token = "b74cb7f19c86b0e80170b41f66dd826e"
				twilio_phone_number = "9177461337"

				@twilio_clinet = Twilio::REST::Client.new twilio_sid, twilio_token

				@twilio_clinet.account.sms.messages.create(
					:from => "#{twilio_phone_number}",
					:to => number_to_send_to,
					:body => "Your shift in the #{area} Area is starts at #{f_time(start_time)}"
				)

				puts "message sent!"
			end
		end
	end
end

