class Slot < ActiveRecord::Base
	has_many :shifts, :dependent => :destroy
	belongs_to :area

	validates :required_shifts, :numericality => {:only_integer => true, :greater_than => 0}

	def shift_titles
		titles = Array.new
		
		self.shifts.each do |shift|
			titles.push(shift.title)
		end

		return titles
	end	

	def import_shift_list
		first_shifts = self.area.slots.first.shifts
		current_shifts = self.shift_titles

		first_shifts.each do |shift|
			unless current_shifts.include? shift.title
				self.shifts.build(:title => shift.title)
				self.save
			end
		end
	end
end
