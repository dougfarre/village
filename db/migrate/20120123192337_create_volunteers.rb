class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :email
      t.string :phone
      t.string :shirt_size
      t.string :city
      t.string :state
      t.string :organization
      t.string :level

      t.timestamps
    end
  end
end
