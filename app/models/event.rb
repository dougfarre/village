class EventValidator < ActiveModel::Validator
	def validate(record)
		begin	
			length = ((record.end_date) - (record.start_date)).to_i
		rescue	
			record.errors[:base] << "Please enter date in both fields."
			return
		end

		if length <= 0 
			record.errors[:base] << "The start date can't be after the end date."
		elsif length > 7  
			record.errors[:base] << "The conference can't be more than 7 days."
		end
	end

	def correct_time(time)
		return Date.parse(time)
	end

end


class Event < ActiveRecord::Base
	has_many :villages, :dependent => :destroy
	has_many :volunteer_events, :dependent => :destroy ##
	has_many :volunteers, :through => :volunteer_events, :dependent => :delete_all
	has_many :data_files, :as => :attachable, :dependent => :destroy
	validates_with EventValidator
	belongs_to :user

	validates :name, :length => {:maximum => 20}, :presence => true

	def self.get_name(event_id)
		return Event.find(event_id).name
	end	
end
