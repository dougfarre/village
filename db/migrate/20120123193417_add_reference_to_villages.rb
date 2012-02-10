class AddReferenceToVillages < ActiveRecord::Migration
  def change
		add_column :shifts, :volunteer_id, :integer
		add_column :shifts, :slot_id, :integer
		add_column :slots, :village_id, :integer
		add_column :areas, :village_id, :integer
		add_column :villages, :event_id, :integer
  end
end
