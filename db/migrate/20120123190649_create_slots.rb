class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
