class Addusertypetouser < ActiveRecord::Migration
  def up
	add_column :users, :user_type, :string
  end

  def down
  end
end
