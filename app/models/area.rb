class Area < ActiveRecord::Base
belongs_to :village
has_many :slots
has_and_belongs_to_many :volunteer_events

validates :name, :length => {:maximum => 15}, :presence => true

	def slots_array 
		num_days = self.num_days
		slots_array_return = Array.new

		(0 .. num_days).each do |i|
			j = ActiveSupport::JSON
			temp = Slot.find(:all, :conditions => {:area_id => id, 
											 :start_date => village.event.start_date + i})
			slots_array_return << (j.encode(temp))
		end		

		return slots_array_return
	end

	def num_days
		return num_days = (village.event.end_date - village.event.start_date).to_i
	end
end
