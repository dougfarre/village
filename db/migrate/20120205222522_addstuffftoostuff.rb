class Addstuffftoostuff < ActiveRecord::Migration
  def up
		add_column :slots, :start_date, :date
		add_column :slots, :start_time, :time
		add_column :slots, :end_time, :time
  end

  def down
  end
end
