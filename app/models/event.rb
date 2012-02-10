class Event < ActiveRecord::Base
has_many :villages, :dependent => :destroy
has_and_belongs_to_many :volunteers

def self.get_name(event_id)
		return Event.find(event_id).name
	end	

end
