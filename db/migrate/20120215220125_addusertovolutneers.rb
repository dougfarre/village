class Addusertovolutneers < ActiveRecord::Migration
  def up
			
		add_column :volunteers, :user_id, :integer

  end

  def down
  end
end
