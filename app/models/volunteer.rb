class Volunteer < ActiveRecord::Base
	has_many :volunteer_events
	has_many :events, :through => :volunteer_events
	belongs_to :user
	validates_presence_of :first_name, :last_name, :nick_name, :phone, :email

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
