class CreateVolunteerEvents < ActiveRecord::Migration
  def change
    create_table :volunteer_events do |t|
			t.integer :event_id
			t.integer :volunteer_id	
			t.integer :required_shifts
      t.timestamps
    end

		create_table :areas_volunteer_events, :id => false do |t|
			t.integer :area_id
			t.integer :volunteer_event_id	
		end
  end

end
