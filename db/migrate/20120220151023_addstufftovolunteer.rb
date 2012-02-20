class Addstufftovolunteer < ActiveRecord::Migration
  def up
		change_table :volunteer_events do |t|
			t.string :email
		end
  end

  def down
  end
end
