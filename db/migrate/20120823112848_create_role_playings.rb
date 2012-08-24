class CreateRolePlayings < ActiveRecord::Migration
  def change
    create_table :role_playings do |t|
      t.integer :role_id
      t.integer :admin_user_id

      t.timestamps
    end
  end
end
