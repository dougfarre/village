class Slot < ActiveRecord::Base
	has_many :shifts, :dependent => :destroy
	belongs_to :area

	validates :required_shifts, :numericality => {:only_integer => true, :greater_than => 0}
	
	def import_shift_list
		first_shifts = self.area.slots.first.shifts

		first_shifts.each do |shift|
			self.shifts.build(:title => shift.title)
			self.save
		end
	end
end
