class Removetables < ActiveRecord::Migration
  def up
		drop_table :calendar_events
		drop_table :calender_events
		drop_table :events_volunteers
		drop_table :installs
  end

  def down
  end
end
