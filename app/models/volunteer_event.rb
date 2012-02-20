class VolunteerEvent < ActiveRecord::Base
	belongs_to :event
	belongs_to :volunteer
	has_and_belongs_to_many :areas
	has_many :avails

	before_save :default_values

	def default_values
		self.required_shifts = 5 unless self.required_shifts
	end
end
