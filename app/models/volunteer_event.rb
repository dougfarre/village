class VolunteerEvent < ActiveRecord::Base
	belongs_to :event
	belongs_to :volunteer
	has_and_belongs_to_many :areas
	has_many :avails, :dependent => :destroy 

	before_save :default_values

	def default_values
		self.required_shifts = 5 unless self.required_shifts
	end

	def has_volunteer
		if volunteer.blank?
			return false
		else
			return true
		end
	end

	def get_email
		if self.email
			return self.email
		elsif has_volunteer
			return self.volunteer.email
		else
			return 'error@error.com'
		end
	end
end
