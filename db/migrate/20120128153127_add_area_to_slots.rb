class AddAreaToSlots < ActiveRecord::Migration
  def change
		add_column :slots, :area_id, :integer
		#remove_column :slots, :village_id
		add_index "slots", ["area_id"], :name => "index_slots_on_area_id"
  end
end
