class EventValidator < ActiveModel::Validator
	def validate(record)
		if (record.end_date - record.start_date).to_i <= 0
			record.errors[:base] << "The start and end dates are not valid."
		end
	end
end


class Event < ActiveRecord::Base
	has_many :villages, :dependent => :destroy
	has_many :volunteer_events
	has_many :volunteers, :through => :volunteer_events
	has_many :data_files, :as => :attachable, :dependent => :destroy
	validates_with EventValidator
	belongs_to :user

	def self.get_name(event_id)
		return Event.find(event_id).name
	end	
end
