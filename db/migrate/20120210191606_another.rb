class Another < ActiveRecord::Migration
  def up
		change_table :data_files do |t|
		t.string :attachable_type
		end
  end

  def down
  end
end
