namespace :alerts do

	task :send_alerts => :environment do
		slots = Slot.find(:all, :conditions => {:start_date => Date.today})
	
		slots.each do |slot|
				time = Time.now + 30.minutes
			if slot.start_time.hour == time.hour &&
				 slot.start_time.min == time.min
				slot.shifts.each do |shift|
					unless shift.volunteer_id.blank?
						shift.send_sms_message
						begin
							UserMailer.shift_alert(shift).deliver!
						rescue
						end
					end
				end
			end
		end
	end
end
