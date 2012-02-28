class Village < ActiveRecord::Base
	belongs_to :event
	has_many :areas, :dependent => :destroy

	validates :name, :length => {:maximum => 15}, :presence => true

	def self.get_name(village_id)
		return Village.find(village_id).name
	end	

end
