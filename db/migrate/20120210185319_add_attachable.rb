class AddAttachable < ActiveRecord::Migration
  def up
		change_table :data_files do |t|
			t.references :attachable
		end
  end

  def down
  end
end
