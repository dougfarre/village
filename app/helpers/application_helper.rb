module ApplicationHelper

	def f_time(input_time)
		return input_time.strftime("%I:%M %P")
	end
end
