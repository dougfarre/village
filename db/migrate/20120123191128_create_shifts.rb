class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :title

      t.timestamps
    end
  end
end
