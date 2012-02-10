class Village < ActiveRecord::Base
	belongs_to :event
	#has_many :slots, :dependent => :destroy
	has_many :areas, :dependent => :destroy
	#attr_accessor :name

	def self.get_name(village_id)
		return Village.find(village_id).name
	end	

end
