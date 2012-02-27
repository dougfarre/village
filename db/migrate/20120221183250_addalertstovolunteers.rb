class Addalertstovolunteers < ActiveRecord::Migration
  def up
		add_column :volunteers, :sms_alerts, :boolean
		add_column :volunteers, :email_alerts, :boolean
  end


  def down
  end
end
