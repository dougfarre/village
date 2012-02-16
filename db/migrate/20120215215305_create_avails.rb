class CreateAvails < ActiveRecord::Migration
  def change
    create_table :avails do |t|
			t.integer :volunteer_event_id
			t.date :event_date
			t.time :start_time
			t.time :end_time
      t.timestamps
    end
  end
end
