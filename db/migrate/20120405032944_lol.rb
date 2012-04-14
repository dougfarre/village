class Lol < ActiveRecord::Migration
  def up
	shifts = Shift.where(:volunteer_id => 9) 
	shifts.each do |shift|
		shift.volunteer_id = ''
		shift.save
	end
	
  end

  def down
  end
end
