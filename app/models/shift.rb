class ShiftValidator < ActiveModel::Validator
	def validate(shift)  
		old_shift = ''

		begin
			old_shift = Shift.find(shift.id)
		rescue
			return
		end

		if shift.volunteer_id.blank?
			return
		end

		if old_shift.volunteer_id == shift.volunteer_id
			return
		end

		volunteer = Volunteer.find(shift.volunteer_id)
		slot = shift.slot	

		other_shifts_local = Shift.where(:slot_id => slot.id, :volunteer_id => volunteer.id)
		
		unless other_shifts_local.blank?
			other_shifts_local.each do |other_shift|
				if other_shift.id != shift.id
					shift.errors[:base] << make_first_shift_error(slot)					
					return
				end
			end
		end

		other_shifts_global = Shift.where(:volunteer_id => volunteer.id)
		other_slots = Array.new	

		unless other_shifts_global.blank?
			other_shifts_global.each do |other_shift|
				range = other_shift.slot.start_time..other_shift.slot.end_time
				if (
						((other_shift.slot.start_date == slot.start_date) && (other_shift.id != shift.id)) &&
						(slot.start_time === range ||	slot.end_time === range)
					 )
					shift.errors[:base] << make_other_shift_error(slot, other_shift.slot)
					return
				end
			end
		end	
	end

	def make_first_shift_error(slot)
		#shift_time = slot.start_time.strftime("%I:%M%p") + ' to ' + slot.end_time.strftime("%I:%M%p") 
		#shift_date = slot.start_date.strftime("%A, %b %d %Y")
		return 'this volunteer is already registered for this same time slot in the same area.'
	end

	def make_other_shift_error(slot, other_slot)
		shift_time = slot.start_time.strftime("%I:%M%p") + ' to ' + slot.end_time.strftime("%I:%M%p") 
		shift_date = slot.start_date.strftime("%A, %b %d %Y")

		other_shift_time = other_slot.start_time.strftime("%I:%M%p") + ' to ' + other_slot.end_time.strftime("%I:%M%p") 
		other_shift_date = other_slot.start_date.strftime("%A, %b %d %Y")
		return 'it interferes with another shift from <u>' + other_shift_time + '</u> in the <u>' + other_slot.area.name + ' Area.</u>' 
	end 
end


class Shift < ActiveRecord::Base
	belongs_to :slot
	has_one :volunteer
	validates_uniqueness_of :slot_id, :scope => :volunteer_id,
													:unless => Proc.new {|shift| shift.volunteer_id.blank?}
	validates_with ShiftValidator

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

