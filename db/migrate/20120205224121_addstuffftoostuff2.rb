class Addstuffftoostuff2 < ActiveRecord::Migration
  def up
		add_column :slots, :required_shifts, :int
  end

  def down
  end
end
