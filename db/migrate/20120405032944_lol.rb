class Lol < ActiveRecord::Migration
  def up
	add_column :volunteers, :receive_sms, :boolean
  end

  def down
  end
end
