class Area < ActiveRecord::Base
belongs_to :village
has_many :slots
has_and_belongs_to_many :volunteer_events
end
