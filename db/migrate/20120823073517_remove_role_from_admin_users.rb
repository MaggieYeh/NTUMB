class RemoveRoleFromAdminUsers < ActiveRecord::Migration
  def up
    remove_column :admin_users, :role
  end

  def down
    add_column :admin_users, :role, :string
  end
end
