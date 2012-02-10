class AddIndexes < ActiveRecord::Migration
  def up
		add_index "areas", ["village_id"], :name => "index_areas_on_village_id"
		add_index "shifts", ["volunteer_id"], :name => "index_shifts_on_volunteer_id"
		add_index "shifts", ["slot_id"], :name => "index_shifts_on_slot_id"
		add_index "slots", ["village_id"], :name => "index_slots_on_village_id"
		add_index "villages", ["event_id"], :name => "index_villages_on_event_id"


  end

  def down
  end
end
