class VolunteerEvent < ActiveRecord::Base
	belongs_to :event
	belongs_to :volunteer
	has_and_belongs_to_many :areas
	has_many :avails
end
