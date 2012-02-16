class AddUsertoEvents < ActiveRecord::Migration
  def up
		add_column :events, :user_id, :integer
  end

  def down
  end
end
